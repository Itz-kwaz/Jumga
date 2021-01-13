import 'package:flutter/material.dart';

///
const Color kPrimaryColor = Color(0xFF40BFFF);
const Color kWhite = Color(0xFFFFFFFF);
const Color kBlack = Color(0xFF414041);
const Color kLightGrey = Color(0xFFEBF0F9);
const Color kBlackTextColor = Color(0xFF101011);
const Color kBlackTwo = Color(0xFF222B45);

const double kBorderRadius = 6.0;

//Currency conversion
const double kDollarToNaira = 500.2;
const double kDollarToGhCedis = 5.86;
const kDollarToKes = 109.60;
const double kDollarToGbp = 0.74;


//SharedPreferences Keys.
const String LOGGED_IN = 'loggedIn';
const String USER_STRING = 'UserString';

var myInputDecoration = InputDecoration(
  hintText: '',
  border: OutlineInputBorder(
      borderSide: BorderSide(
          width: 0.2),
      borderRadius: BorderRadius.circular(6.0)),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: kPrimaryColor, width: 1.0),
    borderRadius: BorderRadius.circular(6),
  ),
);

const kName = 'name';
const kEmail = 'email';
const kCountry = 'country';
const kPhone = 'phone';
const kShopOwner = 'shop_owner';
const kShopName = 'shop_name';
const kEarnedAmount = 'earned_amount';
const kUserId = 'user_id';

///Currrencies

const KSH_SIGN = ' Ksh';
const GBP_SIGN = '£';
const GHS_SIGN = '₵';
const NGN_SIGN = ' ₦';

