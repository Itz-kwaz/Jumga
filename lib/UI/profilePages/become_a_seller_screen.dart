import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:jumga/Core/states/payment_provider.dart';
import 'package:jumga/models/user.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class BecomeSellerScreen extends StatefulWidget {
  final User user;

  BecomeSellerScreen({this.user});

  @override
  _BecomeSellerScreenState createState() => _BecomeSellerScreenState();
}

class _BecomeSellerScreenState extends State<BecomeSellerScreen> {
  final String txref = DateTime.now().toIso8601String();


  final _formKey = GlobalKey<FormState>();

  String amount;

  String currencySign;

  String currency;

  @override
  Widget build(BuildContext context) {
    var textTheme2 = Theme.of(context).textTheme;
    var model = Provider.of<PaymentProvider>(context,listen:false);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: kToolbarHeight,
            ),
            Text(
              'Open a shop',
              style: textTheme2.headline6.copyWith(
                  color: kBlackTextColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 16.0,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Placeholder(
                  color: Colors.blue,
                ),
              ),
            ),
            Text(
              'Hello ${widget.user.name}!, to open a shop you need to pay a small token of \$20. ($currencySign $amount)\n'
              '\nFor every sale Jumga takes a commission of 2.5% and for the delivery fee Jumga takes a commissin of 20%. ',
              style: textTheme2.subtitle1.copyWith(
                  color: kBlackTextColor, fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              'Your Shop Name ',
              style: textTheme2.subtitle1.copyWith(
                  color: kBlackTextColor, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 8.0,
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                validator: (value) {
                  if (value.length < 4) {
                    return 'Please enter at least 4 characters';
                  }
                  return null;
                },
                controller: model.shopNameController,
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: myInputDecoration.copyWith(
                    hintText: 'at least 4 characters'),
              ),
            ),
            Spacer(),
            FlatButton(
              color: kPrimaryColor,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  beginPayment(context);
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Pay $currencySign $amount',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0)),
            ),
            SizedBox(
              height: 32.0,
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initialiseValues();
  }



  beginPayment(context) async {
    var model = Provider.of<PaymentProvider>(context, listen: false);
    final Flutterwave flutterwave = Flutterwave.forUIPayment(
      context: context,
      encryptionKey: model.encryptionKey,
      publicKey: model.publicKey,
      currency: widget.user.country,
      amount: this.amount,
      email: widget.user.email,
      fullName: widget.user.name,
      txRef: this.txref,
      isDebugMode: true,
      phoneNumber: widget.user.phoneNumber,
      acceptCardPayment: true,
      acceptUSSDPayment: true,
      acceptAccountPayment: true,
    );

    try {
      final ChargeResponse response =
          await flutterwave.initializeForUiPayments();
      if (response == null) {
        // user didn't complete the transaction. Payment wasn't successful.
      } else {
        final isSuccessful = checkPaymentIsSuccessful(response);
        if (isSuccessful) {
          // provide value to customer
          _showSuccessDialog();
          var model = Provider.of<PaymentProvider>(context,listen:false);
          model.updateUser();
        } else {
          _showErrorDialog(response.message);
        }
      }
    } catch (error) {
      // handleError(error);
      // print(stacktrace);
    }
  }

  Future<void> _showSuccessDialog() async {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'images/check_mark.svg',
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    'Transaction Successful',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                      color: kBlackTextColor,
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Set Up Shop!'))
            ],
          );
        });
  }

  Future<void> _showErrorDialog(String message) async {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Transaction Failed',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                      color: kBlackTextColor,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    message ?? 'Please try again later',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                      color: kBlackTextColor,
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
            ],
          );
        });
  }

  bool checkPaymentIsSuccessful(final ChargeResponse response) {
    return response.data.status == FlutterwaveConstants.SUCCESSFUL &&
        response.data.currency == this.currency &&
        response.data.amount == this.amount &&
        response.data.txRef == this.txref;
  }

  void initialiseValues() {
    String userCountry = widget.user.country;
    var model = Provider.of<PaymentProvider>(context, listen: false);
    amount = (20 * model.rate).toStringAsFixed(2);

    switch (userCountry) {
      case FlutterwaveCurrency.KES:
        currencySign = KSH_SIGN;
        break;
      case FlutterwaveCurrency.GBP:
        currencySign = GBP_SIGN;
        break;
      case FlutterwaveCurrency.GHS:
        currencySign = GHS_SIGN;
        break;
      default:
        currencySign = NGN_SIGN;
        break;
    }
  }
}
