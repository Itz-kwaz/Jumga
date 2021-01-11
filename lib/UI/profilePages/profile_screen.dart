import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jumga/UI/sign_in_page.dart';
import 'package:jumga/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../become_a_seller_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  User user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                   Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
                    child: SvgPicture.asset(
                      'images/profile_user.svg',
                      height: MediaQuery.of(context).size.width * 0.25,
                      width: MediaQuery.of(context).size.width * 0.25,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                       user.name ?? 'Hello there!',
                        style: TextStyle(
                            color: kBlackTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    )),
                SizedBox(
                  height: kToolbarHeight * 0.5,
                ),
                Container(
                  child: Column(
                    children: [
                      _ListTile(
                          text: 'Profile Details',
                          onTap: () {},
                          imagePath: 'images/user.svg'),
                      _ListTile(
                          text: 'Orders',
                          onTap: () {},
                          imagePath: 'images/shopping_bag_alt.svg'),
                      _ListTile(
                          text: 'Change Password',
                          onTap: () {},
                          imagePath: 'images/padlock.svg'),
                      _ListTile(
                        text: 'Address Book',
                        onTap: () {},
                        imagePath: 'images/map_marker.svg',
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 8.0),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)  => BecomeSellerScreen(),),);
                },
                child: Container(
                    padding:
                    EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0, bottom: 4.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: kBlackTextColor,
                                  borderRadius: BorderRadius.circular(16.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                      'images/info_circle.svg',
                                      color: kWhite,
                                      height: 20.0,
                                      width: 20.0,
                                    ))),
                            SizedBox(
                              width: 8.0,
                            ),
                            Expanded(
                              child: Text(
                                'Open a shop!',
                                style: TextStyle(
                                  color: kBlackTextColor,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: Color(0xFFC5CEE0),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 48.0),
                          child: Divider(
                            color: Color(0xFFC5CEE0),
                          ),
                        )
                      ],
                    )),
              ),
                SizedBox(height: 8.0),
                Container(
                  child: InkWell(
                    onTap: () async {
                      Navigator.of(context).pushAndRemoveUntil(
                        // the new route
                        MaterialPageRoute(
                          builder: (BuildContext context) => SignInPage(),
                        ),

                        (Route route) => false,
                      );
                    },
                    child: Container(
                        padding: EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 6.0, bottom: 4.0),
                        child: Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFFE4E9F2),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.logout,
                                      color: kBlackTwo,
                                    ))),
                            SizedBox(
                              width: 8.0,
                            ),
                            Expanded(
                              child: Text(
                                "Log Out",
                                style: TextStyle(
                                  color: kBlackTextColor,
                                  fontSize: 17.0,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userString = prefs.getString(USER_STRING);
    user = User.fromJson(jsonDecode(userString),);
  }
}

class _ListTile extends StatelessWidget {
  final String text;
  final String imagePath;
  final bool showDivider;
  final GestureTapCallback onTap;

  _ListTile(
      {@required this.text,
      @required this.imagePath,
      this.showDivider,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding:
              EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0, bottom: 4.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            imagePath,
                            color: kWhite,
                            height: 20.0,
                            width: 20.0,
                          ))),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        color: kBlackTextColor,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Color(0xFFC5CEE0),
                  )
                ],
              ),
              Visibility(
                visible: showDivider ?? true,
                child: Padding(
                  padding: EdgeInsets.only(left: 48.0),
                  child: Divider(
                    color: Color(0xFFC5CEE0),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
