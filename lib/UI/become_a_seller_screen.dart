import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';

import '../constants.dart';

class BecomeSellerScreen extends StatelessWidget {
  final String txref = "My_unique_transaction_reference_123";
  final String amount = "200";
  final String currency = FlutterwaveCurrency.NGN;

  @override
  Widget build(BuildContext context) {
    var textTheme2 = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: kToolbarHeight,
            ),
            Text('Open a shop',
              style: textTheme2.headline6.copyWith(
                  color: kBlackTextColor,
                  fontWeight: FontWeight.bold
              ),),
            SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Placeholder(
                  color: Colors.blue,
                ),
              ),
            ),
            Text(
              'Hello there!, to open a shop you need to pay a small token of \$20. \n'
                  '\nFor every sale Jumga takes a commission of 2.5% and for the delivery fee Jumga takes a commissino of 20%. ',
              style: textTheme2.subtitle1.copyWith(
                  color: kBlackTextColor,
                  fontWeight: FontWeight.normal
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Spacer(),
            FlatButton(
              color: kPrimaryColor,
              onPressed: ()  async {
                beginPayment(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Pay \$20',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                  ),),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0)
              ),
            ),
            SizedBox(
              height: 32.0,
            )
          ],
        ),
      ),
    );

  }

  beginPayment(context) async {
    final Flutterwave flutterwave = Flutterwave.forUIPayment(
        context: context,
        encryptionKey: 'FLWSECK_TEST03a21120032e',
        publicKey: 'FLWPUBK_TEST-46256a6a7a5bf105e3502589d14eff23-X',
        currency: this.currency,
        amount: this.amount,
        email: "valid@email.com",
        fullName: "Valid Full Name",
        txRef: this.txref,
        isDebugMode: true,
        phoneNumber: "0123456789",
        acceptCardPayment: true,
        acceptUSSDPayment: false,
        acceptAccountPayment: false,
        acceptFrancophoneMobileMoney: false,
        acceptGhanaPayment: false,
        acceptMpesaPayment: false,
        acceptRwandaMoneyPayment: true,
        acceptUgandaPayment: false,
        acceptZambiaPayment: false);

    try {
      final ChargeResponse response = await flutterwave.initializeForUiPayments();
      if (response == null) {
        // user didn't complete the transaction. Payment wasn't successful.
      } else {
        final isSuccessful = checkPaymentIsSuccessful(response);
        if (isSuccessful) {
          // provide value to customer
        } else {
          // check message
          print(response.message);

          // check status
          print(response.status);

          // check processor error
          print(response.data.processorResponse);
        }
      }
    } catch (error) {
      // handleError(error);
      // print(stacktrace);
    }
  }

  bool checkPaymentIsSuccessful(final ChargeResponse response) {
    return response.data.status == FlutterwaveConstants.SUCCESSFUL &&
        response.data.currency == this.currency &&
        response.data.amount == this.amount &&
        response.data.txRef == this.txref;
  }


}




