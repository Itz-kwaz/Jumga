import 'package:flutter_svg/flutter_svg.dart';

class BankBranches {
  int id;
  String branchName;
  String branchCode;
  String swiftCode;
  String bic;
  int bankId;

  BankBranches({
    this.id,
    this.branchCode,
    this.branchName,
    this.bankId,
    this.bic,
    this.swiftCode,
  });

  factory BankBranches.fromJson(Map<String,dynamic> json) {
    return BankBranches(
      id: json['id'],
      branchName: json['branch_name'],
      branchCode:  json['branch_code'],
      bankId: json['bank_id'],
      swiftCode: json['swift_code'],
      bic: json['bic'],
    );
  }
}
