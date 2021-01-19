import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:jumga/Core/states/cart_provider.dart';
import 'package:jumga/Core/states/payment_provider.dart';
import 'package:jumga/UI/round_button.dart';
import 'package:jumga/models/cart.dart';
import 'package:jumga/models/user.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:jumga/constants.dart';

import 'check_out_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class _CartScreenState extends State<CartScreen> {
  bool isSelectMode = false;

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<CartsProvider>(context, listen: true);
    User user = Provider.of<PaymentProvider>(context,listen:false).user;
    return Scaffold(
      key: _scaffoldState,
      body: Visibility(
        visible: model.cartList.length > 0 ? true : false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: kToolbarHeight * 0.5,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: model.cartList.length,
              itemBuilder: (BuildContext context, int index) {
                return CartCard(
                  cart: model.cartList.elementAt(index),
                );
              },
            )),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: kBlackTextColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Text(
                    '${user.country} ${model.total}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                    ),
                    color: kPrimaryColor,
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckOutScreen())),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Checkout',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
            )
          ],
        ),
        replacement: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: kToolbarHeight,
            ),
            Center(
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.3,
                backgroundColor: kLightGrey,
                child: Icon(
                  Icons.shopping_basket,
                  size: MediaQuery.of(context).size.width * 0.35,
                  color: Color(0xFFFF8C00),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Center(
              child: Text(
                'Your Cart is Empty',
                style: TextStyle(
                  color: kBlackTextColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 24.0,
                ),
              ),
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Jumga always has something for you,'
                        'What are you waiting for? ',
                    style: TextStyle(
                      color: kBlackTextColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 16.5,
                    ),
                    children: [
                      TextSpan(
                        text: 'Start Shopping!!',
                        style: TextStyle(
                          color: kBlackTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      )
                    ]),
              ),
            ))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<CartsProvider>(context,listen:false).initTotal();
  }
}

class CartCard extends StatefulWidget {
  final Cart cart;

  CartCard({this.cart});

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<CartsProvider>(context,listen:true);
    Cart cart = widget.cart;
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Container(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        fit: BoxFit.fitHeight,
                        image: cart.imageUrl,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                cart.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: kBlackTextColor,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DeleteButton(
                              cart: cart,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                cart.price.toString(),
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 32.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  RoundButton(
                                    text: '-',
                                    onTap: () {
                                      if (cart.quantity > 1) {
                                        cart.quantity--;
                                        model.updateTotal(-cart.price);
                                      }
                                    },
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text(
                                      cart.quantity.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: kBlackTextColor,
                                      ),
                                    ),
                                  ),
                                  RoundButton(
                                    text: '+',
                                    onTap: () {
                                      cart.quantity++;
                                      model.updateTotal(cart.price);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({@required this.cart});

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key('Delete ${cart.name}'),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return MyAlertDialog(
                cart: cart,
              );
            });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(Icons.close, color: kPrimaryColor),
        ),
      ),
    );
  }
}

class MyAlertDialog extends StatelessWidget {
  final Cart cart;

  MyAlertDialog({this.cart});

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<CartsProvider>(context, listen: false);
    return AlertDialog(
      title: Text(
        'Are you sure you want to delete ${cart.name}',
        style: TextStyle(
            fontSize: 16.0,
            color: kBlackTextColor,
            fontWeight: FontWeight.normal),
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 16.0,
              ),
            )),
        FlatButton(
            onPressed: () async {
              Navigator.of(context).pop();
              model.deleteItem(cart);
            },
            child: Text(
              'Delete',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 16.0,
              ),
            )),
      ],
    );
  }
}
