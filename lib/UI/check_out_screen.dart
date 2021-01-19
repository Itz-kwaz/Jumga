import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jumga/Core/states/payment_provider.dart';
import 'package:jumga/UI/order_summary_screen.dart';
import 'package:jumga/constants.dart';
import 'package:jumga/models/user.dart';
import 'package:provider/provider.dart';


class CheckOutScreen extends StatefulWidget {
  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}


class _CheckOutScreenState extends State<CheckOutScreen> {
  TextEditingController memoController;
  TextEditingController addressController;
  TextEditingController couponController;
  TextEditingController landMarkController;
  TextEditingController nameController;
  TextEditingController phoneController;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ScrollController _scrollController;


  @override
  void initState() {
    super.initState();
    memoController = TextEditingController();
    addressController = TextEditingController();
    landMarkController = TextEditingController();
    couponController = TextEditingController();
    _scrollController = ScrollController();
    nameController = TextEditingController();
    phoneController = TextEditingController();

    User user = Provider.of<PaymentProvider>(context,listen:false).user;

    nameController.text = user.name;
    phoneController.text = user.phoneNumber;

  }

  @override
  void dispose() {
    memoController.dispose();
    _scrollController.dispose();
    addressController.dispose();
    couponController.dispose();
    landMarkController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Delivery Details'),
        elevation: 2,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          controller: _scrollController,
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
                    child: Text(
                      'Enter Delivery Details',
                      style: TextStyle(
                          color: kBlackTextColor,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            autofocus: false,
                            controller: nameController,
                            validator: (value){
                              if(value.isEmpty){
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            cursorColor: Theme.of(context).primaryColorDark,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor,
                                      width: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    6.0,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(
                                    6.0,
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            autofocus: false,
                            controller: phoneController,
                            validator: (val){
                              String pattern = r'([0-9\s\-]{7,})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$';
                              RegExp regExp = new RegExp(pattern);
                              if (val.length == 0) {
                                return 'Please enter mobile number';
                              }
                              else if (!regExp.hasMatch(val)) {
                                return 'Please enter valid mobile number';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            cursorColor: Theme.of(context).primaryColorDark,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              labelStyle: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor,
                                      width: 0.2
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    6.0,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(
                                    6.0,
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.length < 5) {
                                _scrollController.animateTo(0.0,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                                return 'It seems your address is not complete';
                              }
                              return null;
                            },
                            autofocus: false,
                            controller: addressController,
                            onFieldSubmitted: (email) {
                              _formKey.currentState.validate();
                            },
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            cursorColor: Theme.of(context).primaryColorDark,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius:
                                        BorderRadius.circular(16.0)),
                                    child: Icon(
                                      Icons.location_on,
                                      color: kWhite,
                                    )),
                              ),
                              labelText: "Address",
                              labelStyle: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor,
                                      width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    6.0,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: kPrimaryColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(
                                    6.0,
                                  ),),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            autofocus: false,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius:
                                        BorderRadius.circular(16.0)),
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                    )),
                              ),
                              labelText: "LandMark",
                              labelStyle: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    6.0,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: kPrimaryColor, width: 1.0),
                                  borderRadius: BorderRadius.circular(
                                    6.0,
                                  )),
                            ),
                            controller: landMarkController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            cursorColor: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(kBorderRadius),
                                  border: Border.all(
                                      color: kLightGrey
                                  )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text(
                                      'Note',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0,
                                          color: kBlackTextColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    child: TextField(
                                        autofocus: false,
                                        controller: memoController,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration.collapsed(
                                            hintText:
                                            'Type something you want here',
                                            hintStyle: TextStyle(
                                                color: Color(0xFFC5CEE0),
                                                fontSize:14.0,
                                                fontWeight: FontWeight.normal))),
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  )
                                ],
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(kBorderRadius),
                              border: Border.all(
                                  color: kLightGrey,
                              )
                            ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 8.0),
                                child: TextField(
                                    autofocus: false,
                                    controller: couponController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    cursorColor: Theme.of(context).primaryColorDark,
                                    decoration: InputDecoration.collapsed(
                                        hintText: 'Have A Coupon Code?',
                                        hintStyle: TextStyle(
                                            color: Color(0xFFC5CEE0),
                                            fontSize:14.0,
                                            fontWeight: FontWeight.normal))),
                              )),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Align(
                          alignment: Alignment(0.8, 0.0),
                          child: InkWell(
                            onTap: () async {

                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(6.0)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Validate',
                                        style: TextStyle(
                                            color: kWhite,
                                            fontSize:16.0,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                        visible: false,
                                        child: SpinKitThreeBounce(
                                          color: kWhite,
                                          size: 10.0,
                                        )),
                                    SizedBox(
                                      width: 5.0,
                                    )
                                  ],
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kBorderRadius)
                      ),
                      onPressed: (){

                        if(_formKey.currentState.validate()) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderSummary()));
                        }

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Proceed to Pay',
                        style: TextStyle(
                          color: Colors.white,

                        ),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void proceedToSummary() {


  }


}
