import 'package:flutter/material.dart';
import '../components/round_icon_button.dart';
class ReusableAddLine extends StatelessWidget {
  ReusableAddLine({this.text,this.onTap});
  final String text;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Color(0xFFBF1215),
              fontSize: 20,
            ),
          ),
          RoundIconButton(
            onPressed: () {},
            icon: Icons.add,
          )
        ],
      ),
    );
  }
}