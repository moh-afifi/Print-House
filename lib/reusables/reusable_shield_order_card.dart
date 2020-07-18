import 'package:flutter/material.dart';
import 'package:print5/admin_screens/admin_messgae.dart';
class ReusableShieldOrderCard extends StatelessWidget {

  ReusableShieldOrderCard({this.sender, this.address, this.script,this.model});

  final String sender;
  final String address;
  final String script;
  final String model;

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
                'User: $sender',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black54,
                ),
              ),
              Text(
                'Address: $address',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15.0,
                ),
              ),
              Text(
                'model chosen: $model',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15.0,
                ),
              ),
              Text(
                'script: $script',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15.0,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.message,
                  size: 40,
                  color: Colors.blueAccent,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminMessage(customerName: sender,),
                    ),
                  );
                },
              ),
              //---------------------------------------------------------------
            ],
          ),
        ),
      ),
    );
  }
}
