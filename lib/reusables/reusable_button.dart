import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  ReusableButton({this.onTap});
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:  EdgeInsets.all(8.0),
        child: FlatButton(
          color: Colors.green,
          textColor: Colors.white,
          padding: EdgeInsets.all(8.0),
          onPressed: onTap,
          child: Text(
            "Send",
            style: TextStyle(fontSize: 20.0,color: Colors.white),
          ),
        ),
      ),
    );
  }
}
