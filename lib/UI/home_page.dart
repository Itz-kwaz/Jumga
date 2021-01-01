import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: kToolbarHeight,
          ),
          Container(
            height: kToolbarHeight,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    autofocus: false,
                    controller: _searchController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Search Products',
                      hintStyle: TextStyle(color: Color(0xFF9098B1)),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF9098B1), width: 0.1),
                          borderRadius: BorderRadius.circular(6.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: kPrimaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Icon(
                  Icons.favorite_border_rounded,
                  color: Color(0xFF9098B1),
                ),
                SizedBox(
                  width: 4.0,
                ),
                Icon(
                  Icons.notifications_outlined,
                  color: Color(0xFF9098B1),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
