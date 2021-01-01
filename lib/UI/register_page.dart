import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jumga/UI/sign_in_page.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  String errorMessage;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _nameController;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool passwordVisible = false;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: kToolbarHeight),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(
                      'Register Account',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: kBlackTextColor,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  height: 32.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _textInput('Full Name'),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your full name.';
                          }
                          return null;
                        },
                        autofocus: false,
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Peter Dury',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).hintColor,
                                  width: 0.2),
                              borderRadius: BorderRadius.circular(6.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: kPrimaryColor, width: 1.0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      _textInput('Email'),
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
                        controller: _emailController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        cursorColor: Theme.of(context).primaryColorDark,
                        decoration: InputDecoration(
                          hintText: 'name@samplemail.com',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).hintColor,
                                  width: 0.2),
                              borderRadius: BorderRadius.circular(6.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: kPrimaryColor, width: 1.0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      _textInput('Password'),
                      TextFormField(
                        key: Key('passwordField'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        autofocus: false,
                        obscureText: passwordVisible,
                        keyboardType: TextInputType.text,
                        controller: _passwordController,
                        textInputAction: TextInputAction.next,
                        cursorColor: Theme.of(context).primaryColorDark,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;

                              });
                            },
                          ),
                          hintText: 'password',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).hintColor,
                                width: 0.2,
                              ),
                              borderRadius: BorderRadius.circular(6)),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: kPrimaryColor, width: 1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(height: 32.0),
                    ],
                  ),
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
                          'Register',
                          style: textTheme.button.copyWith(
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
                SizedBox(
                  height: 16.0,
                ),
                FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                    side: BorderSide(
                      color: Color(0xFFBDBDBD),
                      width: 1.0
                    ),),
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.white,
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInPage(),),);

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Have an account? Log In',
                          style: textTheme.button.copyWith(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w700,
                          ),
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
      ),
    );
  }

  Widget _textInput(String text) {
    return Column(
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: kBlackTextColor, fontWeight: FontWeight.normal),
        ),
        SizedBox(height: 8.0),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
