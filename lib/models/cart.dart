import 'package:jumga/models/product.dart';

class Cart extends Product {
  int quantity;
  String name;
  double price;
  String imageUrl;
  String description;
  String id;
  String ownerUserId;


  Cart({
    this.name,
    this.id,
    this.description,
    this.imageUrl,
    this.price,
    this.ownerUserId,
    this.quantity,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      name: json['name'],
      price: json['price'],
      description: json['description'],
      imageUrl: json['image_url'],
      id: json['id'],
      ownerUserId: json['owner_user_id'],
      quantity: json['quantity']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'price': this.price,
      'description': this.description,
      'image_url': this.imageUrl,
      'owner_user_id' : this.ownerUserId,
      'id':this.id,
      'quantity' : this.quantity,
    };
  }
}