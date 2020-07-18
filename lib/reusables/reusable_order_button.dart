import 'package:flutter/material.dart';
class ReusableOrderButton extends StatelessWidget {
  ReusableOrderButton({this.onTap,this.text});
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Card(
            color: Colors.lightBlue,
            elevation: 15,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text(text,style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),
                ),
              ),
            )
        )
    );
  }
}
