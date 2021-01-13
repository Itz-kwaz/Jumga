import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterwave/utils/flutterwave_currency.dart';
import 'package:jumga/UI/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart' as Jm;
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
  TextEditingController _phoneController;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool passwordVisible = true;

  bool loading = false;

  String dropDownValue;
  String countryCode;

  bool enabled = true;

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: kToolbarHeight),
                Text('Register Account',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: kBlackTextColor, fontWeight: FontWeight.w600)),
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
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: myInputDecoration.copyWith(
                          hintText: 'name@sampleemail.com'
                        )
                      ),
                      SizedBox(height: 16.0),
                      _textInput('Phone Number'),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        controller: _phoneController,
                        textInputAction: TextInputAction.next,
                        cursorColor: Theme.of(context).primaryColorDark,
                        decoration: InputDecoration(
                          hintText: '+234813xxxxxx',
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
                      SizedBox(
                        height: 16.0,
                      ),
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
                          hintText: 'at least 6 characters',
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
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border:
                          Border.all(color: Color(0xFFEDF1F7), width: 1.5)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton<String>(
                      hint: Text(
                        'Country',
                        style: TextStyle(
                            color: Color(0xFF8F9BB3),
                            fontWeight: FontWeight.normal),
                      ),
                      isExpanded: true,
                      value: dropDownValue,
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(),
                      onChanged: (value) async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(() {
                          dropDownValue = value;
                        });
                        switch(dropDownValue) {
                          case 'Nigeria':
                            countryCode = FlutterwaveCurrency.NGN;
                            break;
                          case 'Ghana':
                            countryCode = FlutterwaveCurrency.GHS;
                            break;
                          case 'Uk':
                            countryCode = FlutterwaveCurrency.GBP;
                            break;
                          case 'Kenya':
                            countryCode = FlutterwaveCurrency.KES;
                            break;
                          default:
                            countryCode = FlutterwaveCurrency.NGN;
                            break;
                        }
                      },
                      items: ['Nigeria', 'UK', 'Ghana', 'Kenya']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
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
                    color: enabled ? kPrimaryColor : Colors.blue.shade200,
                    onPressed: () async {
                      if (_formKey.currentState.validate() && enabled) {
                        setState(() {
                          loading = true;
                          enabled = false;
                        });
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );

                          await storeUser(userCredential, context);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text('Password too weak'),
                              ),
                            );
                          } else if (e.code == 'email-already-in-use') {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text(
                                  'The account already exists for that email.'),
                            ));
                          }
                        } catch (e) {
                          print(e);
                          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Could not create account please try again later.'),));
                        } finally {
                          setState(() {
                            loading = false;
                            enabled = true;
                          });
                        }
                      }
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
                      side: BorderSide(color: kPrimaryColor, width: 1.0),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.white,
                    onPressed: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignInPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Have an account? Log In',
                      style: textTheme.button.copyWith(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future storeUser(UserCredential userCredential, BuildContext context) async {
      if(userCredential.user != null) {

      SharedPreferences prefs = await SharedPreferences.getInstance();

      Jm.User user = Jm.User(
        name: _nameController.text,
        shopOwner: false,
        phoneNumber: _phoneController.text,
        country: countryCode,
        email:  _emailController.text,
        id: userCredential.user.uid,
        earnedAmount: 0.0,
      );

      CollectionReference users = FirebaseFirestore.instance.collection('users');

      users.doc(user.id).set(user.toJson())
          .then((value) => print("User Added"))
          .catchError((error){
            prefs.setBool('Failed_to_store_user', true);
      });

      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Account created successfully'),));
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInPage() ,),);
    }
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
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
