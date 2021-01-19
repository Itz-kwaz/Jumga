import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Fb;
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:jumga/Core/routes/api_routes.dart';
import 'package:jumga/constants.dart';
import 'package:jumga/models/bank.dart';
import 'package:jumga/models/bank_branches.dart';
import 'package:jumga/models/cart.dart';
import 'package:jumga/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PaymentProvider extends ChangeNotifier {
  User user = User();

  List<Bank> bankList = [];
  List<BankBranches> bankBranchesList = [];

  bool gettingBanks = true;
  bool gettingBankBranches = false;

  Bank selectedBank;
  BankBranches selectedBankBranch;

  TextEditingController shopNameController = TextEditingController();
  double rate = 300.0;
  var publicKey = DotEnv().env['PUBLIC_KEY'];
  var secretKey = DotEnv().env['SECRET_KEY'];
  var encryptionKey = DotEnv().env['ENCRYPTION_KEY'];

  bool makingWithdrawal = false;

  Future<void> getUser() async {
    try {
      final _auth = Fb.FirebaseAuth.instance;
      String userId = _auth.currentUser.uid;
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      var data = await users.doc(userId).get();
      user = User.fromJson(data.data());
    } catch (e) {
      print(e);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String userString = sharedPreferences.getString(USER_STRING);
      final parsed = jsonDecode(userString);
      user = User.fromJson(parsed);
      print(user.shopOwner);
      print('from sharedPreferences');
    } finally {
      notifyListeners();
    }
  }

  Future<void> getExchangeRates() async {
    final _headers = {HttpHeaders.authorizationHeader: 'Bearer $secretKey'};

    try {
      final response =
          await http.get(ApiRoutes.fxRatesUrl(user.country), headers: _headers);

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        rate = parsed['data']['rate'];
        print(rate);
      }
    } catch (e) {
      print(e);
      print('error');
      switch (user.country) {
        case FlutterwaveCurrency.KES:
          rate = kDollarToKes;
          break;
        case FlutterwaveCurrency.GBP:
          rate = kDollarToGbp;
          break;
        case FlutterwaveCurrency.GHS:
          rate = kDollarToGhCedis;
          break;
        default:
          rate = kDollarToNaira;
          break;
      }
    }
  }

  Future<void> updateUser() async {
    user.shopOwner = true;
    user.shopName = shopNameController.text;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(USER_STRING, jsonEncode(user.toJson()));

    final userId = Fb.FirebaseAuth.instance.currentUser.uid;

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .doc(userId ?? user.id)
        .update({
          kShopOwner: true,
          kShopName: shopNameController.text,
        })
        .then((value) => print('user updated'))
        .catchError((e) => updateUser());
    notifyListeners();
  }

  Future<void> getBank() async {
    final _headers = {HttpHeaders.authorizationHeader: 'Bearer $secretKey'};

    try {
      final response =
          await http.get(ApiRoutes.banksUrl(user.country), headers: _headers);

      if (response.statusCode == 200) {
        final list = _parseBanks(response.body);
        if (list != null) {
          bankList = list;
        }
      }
    } catch (e) {
      print(e);
    } finally {
      gettingBanks = false;
    }
  }

  Future<void> getBankBranches(int id) async {
    print('getting branches');
    final _headers = {HttpHeaders.authorizationHeader: 'Bearer $secretKey'};

    try {
      final response =
          await http.get(ApiRoutes.branchCodeUrl(id), headers: _headers);

      if (response.statusCode == 200) {
        final list = _parseBankBranches(response.body);
        if (list != null) {
          bankBranchesList = list;
        }
      }
    } catch (e) {
      print(e);
    } finally {
      gettingBankBranches = false;
    }
  }

  List<Bank> _parseBanks(String body) {
    final parsed = jsonDecode(body);

    return parsed['data'].map<Bank>((json) => Bank.fromJson(json)).toList();
  }

  List<BankBranches> _parseBankBranches(String body) {
    final parsed = jsonDecode(body);
    return parsed['data']
        .map<BankBranches>((json) => BankBranches.fromJson(json))
        .toList();
  }

  void updateBankValue(Bank value) {
    selectedBank = value;
    gettingBankBranches = true;
    selectedBankBranch = null;
    notifyListeners();
    if (user.country == FlutterwaveCurrency.GHS) {
      getBankBranches(value.id);
    }
  }

  void updateBankBranch(BankBranches value) {
    selectedBankBranch = value;
    notifyListeners();
  }

  Future<String> makePayment(Map<String, dynamic> body) async {
    makingWithdrawal = true;
    notifyListeners();
    String message;

    final _headers = {HttpHeaders.authorizationHeader: 'Bearer $secretKey'};

    print(jsonEncode(body));

    try {
      final response = await http.post(
        ApiRoutes.transfersUrl,
        headers: _headers,
        body: jsonEncode(body),
      );
      print(response.body);
      if (response.statusCode == 200) {
        message = jsonDecode(response.body)['message'];
      }
    } catch (e) {
      print(e);
    } finally {
      makingWithdrawal = false;
      notifyListeners();
    }
    return message;
  }

  void updateUserEarnedAmount(List<Cart> cartList) {
    for(Cart cart in cartList) {
      double amountEarned = (cart.price * cart.quantity) * 0.975;
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      users
          .doc(cart.ownerUserId ?? user.id)
          .update({
        kEarnedAmount: amountEarned,
      })
          .then((value) => print('user updated'))
          .catchError((e) => updateUser());
      notifyListeners();
    }
  }
}
