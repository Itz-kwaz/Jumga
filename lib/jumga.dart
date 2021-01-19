import 'package:flutter/material.dart';
import 'package:jumga/Core/states/cart_provider.dart';
import 'package:jumga/Core/states/payment_provider.dart';
import 'package:jumga/Core/states/user_state_provider.dart';
import 'package:provider/provider.dart';
import 'Core/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';


class JumgaApp extends StatelessWidget {

  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return ErrorWidget();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<PaymentProvider>(create: (_) => PaymentProvider()),
              ChangeNotifierProvider<UserStateProvider>(create: (_) => UserStateProvider(),),
              ChangeNotifierProvider<CartsProvider>(create: (_) => CartsProvider(),),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Jumga',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              initialRoute: Routes.splashScreen,
              routes: Routes.routes,
            ),
          );
        }

        return MaterialApp(
          home: Scaffold(
            body: Container(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(child: Text('Please restart app, something went wrong')),
        ),
      ),
    );
  }
}