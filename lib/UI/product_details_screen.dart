import 'package:flutter/material.dart';
import 'package:jumga/Core/states/cart_provider.dart';
import 'package:jumga/Core/states/payment_provider.dart';
import 'package:jumga/UI/round_button.dart';
import 'package:jumga/constants.dart';
import 'package:jumga/models/product.dart';
import 'package:jumga/models/user.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  ProductDetailsScreen({Key key, this.product}) : super(key: key);
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    User user = Provider.of<PaymentProvider>(context,listen:false).user;

    var cartModel = Provider.of<CartsProvider>(context,listen:false);

    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Hero(
                    tag: product.imageUrl,
                    child: FadeInImage.memoryNetwork(
                      image: product.imageUrl,
                      placeholder: kTransparentImage,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(product.name,
            style: Theme.of(context).textTheme.headline6.copyWith(
              color: kBlackTextColor,
              fontWeight: FontWeight.w600,
            ),),
            SizedBox(
              height: 16.0,
            ),
            Text('${user.country} ${product.price}',
              style: Theme.of(context).textTheme.headline6.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),),
            SizedBox(
              height: 16.0,
            ),
            Visibility(
              visible: product.description.isNotEmpty,
              child: Text(
                'Description ',
                style: TextStyle(
                    fontSize:  16.0,
                    color: kBlackTextColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(product.description,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: kBlackTextColor,
                fontWeight: FontWeight.normal,
              ),),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundButton(text: '-',
                onTap: (){
                  if(count > 0) {
                    setState(() {
                      count--;
                    });
                  }

                },),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    count.toString(),
                    style: TextStyle(
                      fontSize: 22,
                      color: kBlackTextColor,
                    ),
                  ),
                ),
                RoundButton(text: '+',
                  onTap: (){

                    setState(() {
                      count++;
                    });
                  },),
              ],
            ),
            Spacer(),
            FlatButton(
              color: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBorderRadius),
              ),
              onPressed: () {
                if(count >  0) {
                  cartModel.addToCart(product,count);
                  SnackBar snackBar = SnackBar(
                    content: Text('Item added to cart.'),
                  );
                  _scaffoldKey.currentState.showSnackBar(snackBar);
                }
              },
             child: Center(
               child: Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: Text('Add to cart',
            style: Theme.of(context).textTheme.button.copyWith(
                  color: Colors.white
            ),),
               ),
             ),),
            SizedBox(
              height: 16.0,
            )

          ],
        ),
      ),
    );
  }


}



