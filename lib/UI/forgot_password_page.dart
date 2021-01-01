import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jumga/constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _controller;

  bool loading = false;


  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme2 = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: kToolbarHeight,
              ),
              Text('Forgot Password?',
              style: textTheme2.headline5.copyWith(
                color: kBlackTextColor,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(
                height: 16.0,
              ),
              Text('Please, enter your email address. You will receive a link to create a new password via email.',
                textAlign: TextAlign.start,
                style: textTheme2.subtitle2.copyWith(
                  color: kBlackTextColor,
                  fontWeight: FontWeight.normal
                ),
              ),
              SizedBox(
                height: 32.0,
              ),
              Text('Email Address',
              style: textTheme2.headline6.copyWith(
                fontWeight: FontWeight.normal,
                color: kBlackTextColor,
              ),),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                key: Key('EmailField'),
                validator: (value) {
                  bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);
                  if (!emailValid) {
                    return 'Please enter a valid email.';
                  }
                  return null;
                },
                autofocus: false,
                controller: _controller,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                cursorColor: Theme.of(context).primaryColorDark,
                decoration: InputDecoration(
                  hintText: 'name@samplemail.com',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).hintColor,
                          width: 0.2),
                      borderRadius: BorderRadius.circular(4.0)),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: kPrimaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kBorderRadius)),
                  padding: const EdgeInsets.all(16.0),
                  color: kPrimaryColor,
                  onPressed: () async {

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Send Reset Link',
                        style: textTheme2.button.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Visibility(
                        visible: loading,
                        child: SpinKitThreeBounce(
                          color: Colors.white,
                          size: 15.0,
                        ),
                      )
                    ],
                  )),

            ],
          ),
        ),
      ),
    );
  }
}
