
import 'package:flutter/material.dart';
import 'package:jumga/constants.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final Color color;
  final GestureTapCallback onTap;

  RoundButton({@required this.text,this.color,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: Colors.transparent,
      elevation: 1.0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        splashColor: Colors.blueGrey,
        child: Ink(
          height: 40.0,
          width: 40.0,
          decoration: BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}