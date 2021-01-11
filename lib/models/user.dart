import '../constants.dart';

class User {
  String name;
  String email;
  String phoneNumber;
  String country;
  bool shopOwner;
  String shopName;

  User({this.name,this.country,this.email,this.phoneNumber,this.shopOwner,this.shopName});

  factory User.fromJson(Map<String,dynamic> json) {
    return User(
      name: json[kName],
      email: json[kEmail],
      country: json[kCountry],
      phoneNumber: json[kPhone],
      shopOwner: json[kShopOwner],
      shopName: json[kShopName]
    );
  }

  Map<String,dynamic> toJson(){
    Map<String, dynamic> data = Map<String, dynamic>();
    data[kName] = this.name;
    data[kEmail] = this.email;
    data[kCountry] = this.country;
    data[kPhone] = this.phoneNumber;
    data[kShopOwner] = this.shopOwner;
    data[kShopName] = this.shopName;
    return data;
  }
}