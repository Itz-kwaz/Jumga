import 'package:flutter/cupertino.dart';
import 'package:jumga/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserState{
  SELLER_STATE,
  BUYER_STATE,
}
class UserStateProvider extends ChangeNotifier{
  UserState userState;



  init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isBuyer = sharedPreferences.getBool(IS_BUYER_STATE) ?? true;
    if(isBuyer ) {
      userState = UserState.BUYER_STATE;
    }else {
      userState = UserState.SELLER_STATE;
    }
  }

  changeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(userState == UserState.BUYER_STATE) {
      this.userState = UserState.SELLER_STATE;
      prefs.setBool(IS_BUYER_STATE,false);
    } else {
      this.userState = UserState.BUYER_STATE;
      prefs.setBool(IS_BUYER_STATE,true);
    }

  }
}