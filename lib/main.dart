import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jumga/jumga.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DotEnv().load('keys.env');
  runApp(
      JumgaApp(),
  );
}




