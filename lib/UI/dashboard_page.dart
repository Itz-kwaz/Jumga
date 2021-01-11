import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  TextEditingController _searchController;
  List imgList = [
    'images/OfferBanner.svg',
    'images/ProductBanner.svg'
  ];
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
          ),
        /*  Container(
              child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index,reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  autoPlay: true,
                ),
                items: imgList.map((url) {
                  return Container(
                    child: SvgPicture.asset(url)
                  );
                }).toList(),
              )
          ),*/
     /* Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imgList.map((url) {
          int index = imgList.indexOf(url);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentIndex == index
                  ? Color.fromRGBO(0, 0, 0, 0.9)
                  : Color.fromRGBO(0, 0, 0, 0.4),
            ),
          );
        }).toList(),
      ),*/



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
