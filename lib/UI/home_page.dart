import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jumga/Core/states/payment_provider.dart';
import 'package:jumga/Core/states/user_state_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import 'cart_screen.dart';
import 'dashboard_page.dart';
import 'profilePages/profile_screen.dart';
import 'shopOwnerUi/so_items_screen.dart';
import 'shopOwnerUi/so_dashboard_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<UserStateProvider>(context,listen: true);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: TextStyle(color: kLightGrey),
        selectedItemColor: kPrimaryColor,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'images/home.svg',
                color: _currentIndex == 0 ? kPrimaryColor : Color(0xFF77838F),
                width: 20.0,
                height: 20.0,
              ),
              label: 'Home'
          ),
         model.userState == UserState.BUYER_STATE ? BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'images/cart.svg',
                color: _currentIndex == 1 ? kPrimaryColor : Color(0xFF77838F),
                width: 20.0,
                height: 20.0,
              ),
              label: 'Cart'
          ) : BottomNavigationBarItem(
             icon:SvgPicture.asset(
               'images/carbon_category.svg',
               color: _currentIndex == 1 ? kPrimaryColor : Color(0xFF77838F),
               width: 20.0,
               height: 20.0,
             ),
             label: 'Items'
         ) ,
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'images/user.svg',
                color: _currentIndex == 2 ? kPrimaryColor : Color(0xFF77838F),
                width: 20.0,
                height: 20.0,
              ),
              label: 'Profile'
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: model.userState ==  UserState.BUYER_STATE ? [
        DashBoardPage(),
          CartScreen(),
          AccountScreen(),
        ] : [
          SoDashBoardScreen(),
          ItemsScreen(),
          AccountScreen(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
   init();
  }

  void init() async {
    var model = Provider.of<PaymentProvider>(context,listen:false);
     await model.getUser();
     model.getExchangeRates();
  }
}
