class Bank {
  int id;
  String name;
  String code;

  Bank({this.name, this.id,this.code,});

  factory Bank.fromJson(Map<String,dynamic> json) {
    return Bank(
      id: json['id'],
      name: json['name'],
      code: json['code'],
    );
  }

  @override
  int get hashCode {
    return id;
  }

  @override
  bool operator ==(Object other) {
    return other is Bank && other.id == this.id && other.name == this.name && other.code == this.code;
  }
}