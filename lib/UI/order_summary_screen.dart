import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:jumga/Core/states/cart_provider.dart';
import 'package:jumga/Core/states/payment_provider.dart';
import 'package:jumga/models/cart.dart';
import 'package:jumga/models/user.dart';
import 'package:provider/provider.dart';
import 'package:jumga/constants.dart';


class OrderSummary extends StatefulWidget {

  final Map<String,String> valueMap;
  OrderSummary({this.valueMap});

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  bool isExpanded = false;
  User user;




  @override
  void initState() {
    super.initState();
    user = Provider.of<PaymentProvider>(context,listen:false).user;
  }


  final String txtRef = DateTime.now().toIso8601String();


  @override
  Widget build(BuildContext context) {
    var model = Provider.of<CartsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 1,
        title: Text('Order Summary'),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: kLightGrey,
                              width: 0.5,
                            )
                        ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 8.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "Order Bill",
                                  style: TextStyle(
                                      color: kBlackTextColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                  ),
                                ),
                              ),

                              Visibility(
                                visible: true,
                                child: SummaryCard(
                                  title: 'Coupon Discount',
                                  trailingText: '0'
                                ),
                              ),

                              Visibility(
                                visible: true,
                                child: SummaryCard(
                                  title: 'Delivery Fee',
                                  trailingText: '200'
                                ),
                              ),
                              Visibility(
                                visible: true,
                                child:   Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Text(
                                                'Grand Total',
                                                style: TextStyle(
                                                    color: kBlackTextColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Text(
                                                '${user.country} ${model.total + 200}',
                                                style: TextStyle(
                                                    color: kBlackTextColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Divider(
                                        height: 4.0,
                                        color: kLightGrey,
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                              ExpansionPanelList(
                                elevation: 0,
                                expansionCallback: (int index, bool val) {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                children: [
                                  ExpansionPanel(
                                    headerBuilder: (BuildContext context, bool isExpanded) {
                                      return ListTile(
                                        trailing: Text(
                                          '${model.cartList
                                              .length} ${model.cartList
                                              .length < 2 ? 'Item' : 'Items' }',
                                          style: TextStyle(
                                              color: kBlackTextColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0,
                                          ),
                                        ),
                                        title: Padding(
                                          padding:
                                          const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            'Cart Items',
                                            style: TextStyle(
                                                color: kBlackTextColor,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    body: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: model.cartList.length,
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        Cart cart = model.cartList.elementAt(index);
                                        return Column(
                                          children: [
                                            ListTile(
                                              title: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16.0),
                                                child: Text(
                                                  cart.name,
                                                  style: TextStyle(
                                                      color: kBlackTextColor,
                                                      fontSize: 14.0,
                                                  ),
                                                ),
                                              ),
                                              subtitle: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 16.0),
                                                child: Text(
                                                  '${cart.quantity}',
                                                  style: TextStyle(
                                                      color: Color(0xFF8F9BB3),
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight
                                                          .w600),
                                                ),
                                              ),
                                              trailing: Text(
                                                '${user.country} ${cart.price}',
                                                style: TextStyle(
                                                    color: kPrimaryColor,
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight
                                                        .w600),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8.0,
                                              ),
                                              child: Divider(
                                                height: 4.0,
                                                color: kLightGrey,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    isExpanded: isExpanded,
                                  ),
                                ],
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: kPrimaryColor,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(kBorderRadius),
                 ),
                 onPressed: (){
                  beginPayment(context,model.total);
                 },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Pay ${model.total + 200}',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            )
          ],
        ),
      ),
    );
  }

  beginPayment(context,double total) async {
    var model = Provider.of<PaymentProvider>(context, listen: false);

    final Flutterwave flutterwave = Flutterwave.forUIPayment(
      context: context,
      encryptionKey: model.encryptionKey,
      publicKey: model.publicKey,
      currency: model.user.country,
      amount: total.toString(),
      email: model.user.email,
      fullName: model.user.name,
      txRef: this.txtRef,
      isDebugMode: true,
      phoneNumber: model.user.phoneNumber,
      acceptCardPayment: true,
      acceptUSSDPayment: true,
      acceptAccountPayment: true,
    );

    try {
      final ChargeResponse response = await flutterwave.initializeForUiPayments();
      if (response == null) {
        // user didn't complete the transaction. Payment wasn't successful.
      } else {
        final isSuccessful = checkPaymentIsSuccessful(response);
        print(isSuccessful);
        if (isSuccessful) {
          // provide value to customer
          _showSuccessDialog();
           var cartModel = Provider.of<CartsProvider>(context,listen:false);
          model.updateUserEarnedAmount(cartModel.cartList);
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
    return response.data.status == FlutterwaveConstants.SUCCESSFUL;
  }

}

class SummaryCard extends StatelessWidget {
  final String title;
  final String trailingText;

  SummaryCard({ @required this.title, @required this.trailingText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: kBlackTextColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    trailingText,
                    style: TextStyle(
                        color: kBlackTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: Divider(
            height: 4.0,
            color: kLightGrey,
          ),
        ),
      ],
    );
  }
}
