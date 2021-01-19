import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:jumga/Core/states/payment_provider.dart';
import 'package:jumga/constants.dart';
import 'package:jumga/models/bank.dart';
import 'package:jumga/models/bank_branches.dart';
import 'package:provider/provider.dart';

class WithdrawalScreen extends StatefulWidget {
  @override
  _WithdrawalScreenState createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  TextEditingController _accountNumberController;
  TextEditingController _accountNameController;
  TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _accountNumberController = TextEditingController();
    _accountNameController = TextEditingController();
    _amountController = TextEditingController();
    Provider.of<PaymentProvider>(context, listen: false).getBank();
  }

  @override
  void dispose() {
    _accountNumberController.dispose();
    _accountNameController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final String txref = DateTime.now().toIso8601String();

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<PaymentProvider>(context, listen: true);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: kToolbarHeight,
                ),
                Text(
                  'Account Name',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: kBlackTextColor),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your full name.';
                    }
                    return null;
                  },
                  autofocus: false,
                  controller: _accountNameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Peter Dury',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.2),
                        borderRadius: BorderRadius.circular(6.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Account Number',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: kBlackTextColor),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your account  number.';
                    }
                    return null;
                  },
                  autofocus: false,
                  controller: _accountNumberController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Account number',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.2),
                        borderRadius: BorderRadius.circular(6.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Amount',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: kBlackTextColor),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your withdrawal amount.';
                    }
                    return null;
                  },
                  autofocus: false,
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: '0.00',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.2),
                        borderRadius: BorderRadius.circular(6.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Banks',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: kBlackTextColor),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Color(0xFFEDF1F7), width: 1.5)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton<Bank>(
                      hint: Row(
                        children: [
                          SizedBox(
                            width: 8.0,
                          ),
                          Flexible(
                            child: Text(
                              'Banks',
                              style: TextStyle(
                                  color: Color(0xFF8F9BB3),
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Visibility(
                            visible: model.gettingBanks,
                            child: SpinKitThreeBounce(
                              color: Color(0xFF8F9BB3),
                              size: 15.0,
                            ),
                          )
                        ],
                      ),
                      isExpanded: true,
                      value: model.selectedBank,
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(),
                      onChanged: (value) async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        model.updateBankValue(value);
                      },
                      items: model.bankList
                          .map<DropdownMenuItem<Bank>>((Bank value) {
                        return DropdownMenuItem<Bank>(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Visibility(
                  visible: model.user.country == FlutterwaveCurrency.GHS,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bank Branches',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: kBlackTextColor),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                                color: Color(0xFFEDF1F7), width: 1.5)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: DropdownButton<BankBranches>(
                            hint: Row(
                              children: [
                                SizedBox(
                                  width: 8.0,
                                ),
                                Flexible(
                                  child: Text(
                                    'Bank branches',
                                    style: TextStyle(
                                        color: Color(0xFF8F9BB3),
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Visibility(
                                  visible: model.gettingBankBranches,
                                  child: SpinKitThreeBounce(
                                    color: Color(0xFF8F9BB3),
                                    size: 15.0,
                                  ),
                                )
                              ],
                            ),
                            isExpanded: true,
                            value: model.selectedBankBranch,
                            icon: Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            elevation: 16,
                            underline: Container(),
                            onChanged: (value) async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              model.updateBankBranch(value);
                            },
                            items: model.bankBranchesList
                                .map<DropdownMenuItem<BankBranches>>(
                                    (BankBranches value) {
                              return DropdownMenuItem<BankBranches>(
                                value: value,
                                child: Text(value.branchName),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32.0,
                ),
                FlatButton(
                  color: kPrimaryColor,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      Map<String, dynamic> body = Map<String, dynamic>();
                      body['account_bank'] = model.selectedBank.code;
                      body['account_number'] = _accountNumberController.text;
                      body['beneficiary_name'] = _accountNameController.text;
                      body['amount'] = int.parse(_amountController.text);
                      body['currency'] = model.user.country;
                      body['reference'] = txref;

                      String message = await model.makePayment(body);
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Make Withdrawal',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Visibility(
                          visible: model.makingWithdrawal,
                          child: SpinKitThreeBounce(
                            color: Colors.white,
                            size: 15.0,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
