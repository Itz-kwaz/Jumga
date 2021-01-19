import 'package:flutter/material.dart';
import 'package:jumga/Core/states/payment_provider.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';


enum _TransactionType{
  CREDIT,
  DEBIT
}
class SoDashBoardScreen extends StatefulWidget {
  @override
  _SoDashBoardScreenState createState() => _SoDashBoardScreenState();
}

class _SoDashBoardScreenState extends State<SoDashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    var model = Provider.of<PaymentProvider>(context, listen: false);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: kToolbarHeight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hi!\n${model.user.name ?? 'there'}',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: kBlackTextColor, fontWeight: FontWeight.w600),
                ),
                Icon(
                  Icons.notifications,
                  color: kBlackTextColor,
                )
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Card(
              color: kPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment(-0.9, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.account_balance_rounded,
                        color: Colors.white,
                        size: 35.0,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Total Balance',
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.white, fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        '${model.user.country ?? '0.0'} ${model.user.earnedAmount.toString()}',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Activity',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: kBlackTextColor, fontWeight: FontWeight.bold),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                        color: kBlackTextColor, fontWeight: FontWeight.normal),
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return _TransactionWidget(
                    transactionType: index % 2 == 0 ? _TransactionType.CREDIT : _TransactionType.DEBIT,
                    transactionAmount:  index % 2 == 0 ? '+ 80,000' : '- 50,000',
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TransactionWidget extends StatelessWidget {
  final  _TransactionType transactionType;
  final String transactionAmount;
  const _TransactionWidget({
    Key key,
    this.transactionType,
    this.transactionAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
        transactionType == _TransactionType.CREDIT ?  Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              shape: BoxShape.circle
            ),
            child: Icon(
              Icons.add,
              color: Colors.green.shade700,
            ),
          ) : Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              color: Colors.red.shade100,
              shape: BoxShape.circle
          ),
          child: Icon(
            Icons.remove,
            color: Colors.red.shade700,
          ),
        ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Samsung A21s',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: kBlackTextColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Oct  11 - 12.04 p.m',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: kBlackTextColor,
                      fontWeight: FontWeight.normal
                  ),
                ),
              ],
            ),
          ),
          Text(transactionAmount,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
            color:   transactionType == _TransactionType.CREDIT ? Colors.green.shade700 : Colors.red.shade700 ,
          ),)
        ],
      ),
    );
  }
}
