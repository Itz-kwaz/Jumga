import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Fb;
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:jumga/Core/routes/api_routes.dart';
import 'package:jumga/constants.dart';
import 'package:jumga/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PaymentProvider extends ChangeNotifier {
  User user = User();

  TextEditingController shopNameController = TextEditingController();
  double rate = 300.0;
 var  publicKey = DotEnv().env['PUBLIC_KEY'];
 var  secretKey = DotEnv().env['SECRET_KEY'];
 var encryptionKey = DotEnv().env['ENCRYPTION_KEY'];

  Future<void> getUser() async {

    try {
      final _auth = Fb.FirebaseAuth.instance;
      String userId = _auth.currentUser.uid;
      CollectionReference users = FirebaseFirestore.instance.collection(
          'users');
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

    }
  }

  Future<void> getExchangeRates() async {

    final _headers = {
      HttpHeaders.authorizationHeader: 'Bearer $secretKey'
    };

    try{
      final response = await http.get(ApiRoutes.fxRates(user.country),
          headers: _headers);

      if(response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        rate = parsed['data']['rate'];
        print(rate);
      }
    }catch(e) {
      print(e);
      print('error');
      switch(user.country) {
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

  Future<void> updateUser()  async{
    user.shopOwner = true;
    user.shopName = shopNameController.text;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(USER_STRING, jsonEncode(user.toJson()));

    final userId = Fb.FirebaseAuth.instance.currentUser.uid;

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(userId ?? user.id).update({
      kShopOwner: true,
      kShopName: shopNameController.text,
    }).then((value) => print('user updated')).catchError(() => updateUser());
  }



  }

