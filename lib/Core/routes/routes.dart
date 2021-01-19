import 'package:flutter/material.dart';
import 'package:jumga/UI/home_page.dart';
import 'package:jumga/UI/product_details_screen.dart';
import 'package:jumga/UI/register_page.dart';
import 'package:jumga/UI/shopOwnerUi/add_item_screen.dart';
import 'package:jumga/UI/shopOwnerUi/so_dashboard_screen.dart';
import 'package:jumga/UI/shopOwnerUi/so_items_screen.dart';
import 'package:jumga/UI/sign_in_page.dart';
import 'package:jumga/UI/splash_screen.dart';

class Routes {

  static const String registerPage = 'registerPage';
  static const String signInScreen = 'signInScreen';
  static const String homeScreen = 'homeScreen';
  static const String splashScreen = 'splashScreen';
  static const String productDetailsScreen = 'productDetailsScreen';

  ///Shop Owner Screens

   static const String itemsScreen = 'itemsScreen';
  static const String shopOwnerDashBoardScreen = 'shopOwnerDashBoardScreen';
  static const String addItemScreen = 'addItemScreen';

  static Map<String, Widget Function(BuildContext)> routes = {
    registerPage : (context) => RegisterPage(),
    signInScreen: (context) => SignInPage(),
    homeScreen: (context) => HomePage(),
    shopOwnerDashBoardScreen: (context) => SoDashBoardScreen(),
    splashScreen: (context) => SplashScreen(),
    itemsScreen: (context) => ItemsScreen(),
    addItemScreen :(context) => AddItemScreen(),
    productDetailsScreen: (context) => ProductDetailsScreen()
  };

}