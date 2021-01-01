import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jumga/UI/home_page.dart';
import 'package:jumga/UI/sign_in_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

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
          return MaterialApp(
            home: Scaffold(
              body: Container(
                color: Colors.white,
                child: Center(child: Text('Please restart app, something went wrong')),
              ),
            ),
          );
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Jumga',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomePage(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
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


