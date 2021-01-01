import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constants.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  TextEditingController _emailController;
  TextEditingController _passwordController;

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
                      'Login',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: kBlackTextColor,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      SizedBox(height: 16.0),
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
                          'LOGIN',
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Divider(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                Center(
                  child: FlatButton(
                    onPressed: () async {},
                    child: Text(
                      'Forgot password?',
                      style: textTheme.subtitle1.copyWith(
                          color: kPrimaryColor, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
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
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
