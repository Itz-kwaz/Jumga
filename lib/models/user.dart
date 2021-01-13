import '../constants.dart';

class User {
  String name;
  String id;
  String email;
  String phoneNumber;
  String country;
  bool shopOwner;
  String shopName;
  double earnedAmount;

  User({this.name,this.id,this.country,this.email,this.phoneNumber,this.shopOwner = false,this.shopName,this.earnedAmount});

  factory User.fromJson(Map<String,dynamic> json) {
    return User(
      name: json[kName],
      email: json[kEmail],
      country: json[kCountry],
      phoneNumber: json[kPhone],
      shopOwner: json[kShopOwner] ?? false,
      shopName: json[kShopName],
      earnedAmount: json[kEarnedAmount],
      id: json[kUserId]
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
    data[kUserId] = this.id;
    data[kEarnedAmount]= this.earnedAmount;
    return data;
  }
}