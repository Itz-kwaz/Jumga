import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jumga/Core/routes/routes.dart';
import 'package:jumga/Core/states/payment_provider.dart';
import 'package:jumga/Core/states/user_state_provider.dart';
import 'package:jumga/constants.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Text('Jumga',
        style: Theme.of(context).textTheme.headline5.copyWith(
          color: Colors.white
        ),),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
      init();
  }

  Future init() async {
     var model = Provider.of<UserStateProvider>(context,listen:false);
    model.init();
     await Provider.of<PaymentProvider>(context,listen:false).getUser();
     final _auth = FirebaseAuth.instance;
     User user = _auth.currentUser;
     if(user != null) {
       Navigator.of(context).pushNamed(Routes.homeScreen);
     } else {
       Navigator.of(context).pushNamed(Routes.signInScreen);
     }

  }
}
