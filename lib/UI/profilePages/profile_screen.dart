import 'package:firebase_auth/firebase_auth.dart' as FB;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jumga/Core/routes/routes.dart';
import 'package:jumga/Core/states/payment_provider.dart';
import 'package:jumga/Core/states/user_state_provider.dart';
import 'package:jumga/UI/shopOwnerUi/withdrawal_screen.dart';
import 'package:jumga/UI/sign_in_page.dart';
import 'package:jumga/models/user.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'become_a_seller_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
   var model =  Provider.of<PaymentProvider>(context,listen:true);
   var userStateModel = Provider.of<UserStateProvider>(context,listen:false);
   User user = model.user;
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
                          text: 'Change Password',
                          onTap: () {
                            var model = Provider.of<PaymentProvider>(context,listen:false);
                            model.updateUser();
                          },
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
              Visibility(
                visible: !user.shopOwner,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)  => BecomeSellerScreen(user: user),),);
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
                                        'images/shopping_bag_alt.svg',
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
                                    fontWeight: FontWeight.bold
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
              ),
                Visibility(
                  visible: user.shopOwner,
                  child: InkWell(
                    onTap: () async{

                     await  userStateModel.changeState();

                        Navigator.of(context).popAndPushNamed(Routes.homeScreen);

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
                                        child: Icon(Icons.cached_rounded,
                                        color: Colors.white,)
                                    ),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Expanded(
                                  child: Text(
                                   userStateModel.userState == UserState.BUYER_STATE ? 'Switch to shop mode!' : 'Switch to buyer mode',
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
                ),
                Visibility(
                  visible: userStateModel.userState == UserState.SELLER_STATE,
                  child: _ListTile(
                    text: "Withdraw funds",
                    imagePath: 'images/credit_card.svg',
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => WithdrawalScreen()));
                    },
                  ) ,
                ),
                SizedBox(height: 8.0),
                Container(
                  child: InkWell(
                    onTap: () async {
                      final _auth = FB.FirebaseAuth.instance;
                      await _auth.signOut();
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
