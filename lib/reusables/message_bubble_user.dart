import 'package:flutter/material.dart';

class ReusableUserMsgCard extends StatelessWidget {
  ReusableUserMsgCard({this.sender,this.message});

  final String sender;
  final String message;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        elevation: 5.0,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'From: $sender',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black54,
                ),
              ),
              Text(
                'Message: $message',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15.0,
                ),
              ),
              //---------------------------------------------------------------
            ],
          ),
        ),
      ),
    );
  }
}
