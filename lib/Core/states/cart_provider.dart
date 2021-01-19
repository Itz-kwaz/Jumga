import 'package:flutter/material.dart';
import 'package:jumga/models/cart.dart';
import 'package:jumga/models/product.dart';

class CartsProvider extends ChangeNotifier {
  List<Cart> cartList = [];
  double total = 0 ;

  addToCart(Product product, int quantity) {
    cartList.add(
      cartFromProduct(product, quantity),
    );
    total += product.price * quantity;
    notifyListeners();
  }

  Cart cartFromProduct(Product product, int quantity) {
    return Cart(
      name: product.name,
      quantity: quantity,
      ownerUserId: product.ownerUserId,
      id: product.id,
      imageUrl: product.imageUrl,
      description: product.description,
      price: product.price,
    );
  }

  void deleteItem(Cart cart) {
    cartList.remove(cart);
    notifyListeners();
  }

  updateTotal(double price) {
    total += price;
    notifyListeners();
  }

  initTotal(){
    for (Cart cart in cartList) {
      total = cart.price * cart.quantity;
    }
  }
}
