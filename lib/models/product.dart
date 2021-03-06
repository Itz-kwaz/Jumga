class Product {
  String name;
  double price;
  String imageUrl;
  String description;
  String id;
  String ownerUserId;

  Product({
    this.name,
    this.id,
    this.description,
    this.imageUrl,
    this.price,
    this.ownerUserId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'],
      description: json['description'],
      imageUrl: json['image_url'],
      id: json['id'],
      ownerUserId: json['owner_user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'price': this.price,
      'description': this.description,
      'image_url': this.imageUrl,
      'owner_user_id' : this.ownerUserId,
      'id':this.id
    };
  }
}
