import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jumga/Core/states/payment_provider.dart';
import 'package:jumga/UI/product_details_screen.dart';
import 'package:jumga/models/product.dart';
import 'package:jumga/models/user.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import '../constants.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  TextEditingController _searchController;
  List imgList = ['images/OfferBanner.svg', 'images/ProductBanner.svg'];


  @override
  Widget build(BuildContext context) {
    CollectionReference products = FirebaseFirestore.instance.collection('products');

    User user = Provider.of<PaymentProvider>(context,listen:false).user;

    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: products.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Something went wrong'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SpinKitDoubleBounce(
              size: 150,
              color: kPrimaryColor,
            ),
          );
        }
        return Column(
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
            Expanded(
              child: GridView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = Product(
                    name: snapshot.data.docs[index].data()['name'],
                    price: snapshot.data.docs[index].data()['price'],
                    description: snapshot.data.docs[index].data()['description'],
                    imageUrl: snapshot.data.docs[index].data()['image_url'],
                  /*  id: snapshot.data.docs[index].data()['id'],
                    ownerUserId: snapshot.data.docs[index].data()['owner_user_id'],*/
                  );
                  return InkWell(
                    onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder:(context) => ProductDetailsScreen(product: product,),),),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Hero(
                                tag: product.imageUrl,
                                child: FadeInImage.memoryNetwork(
                                  image: product.imageUrl,
                                  placeholder: kTransparentImage,
                                ),
                              ),
                            ),
                            Text(
                              product.name,
                              style:
                                  Theme.of(context).textTheme.subtitle1.copyWith(
                                        color: kBlackTextColor,
                                      ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              '${user.country} ${product.price.toString()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              ),
            )
          ],
        );
      },
    ));
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
