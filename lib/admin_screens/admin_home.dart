import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'gift_orders.dart';
import 'package:print5/admin_screens/tshirt_orders.dart';
import 'file_orders.dart';
import 'package:print5/reusables/reusable_order_button.dart';
import 'shield_oreders.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: GradientAppBar(
        centerTitle: true,
        title: Text(
          'Orders',
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 40),
        ),
        elevation: 0.0,
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Color(0xFFBF1215), Color(0xFF3A6186)]),
      ),
      //---------------------------------------------------------------------
      body: Center(
        child: Padding(
          padding:  EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ReusableOrderButton(
                text: 'Gift Orders',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GiftOrders(),
                    ),
                  );
                },
              ),
              //-------------------------------------------------------------
              ReusableOrderButton(
                text: 'File Orders',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FileOrders(),
                    ),
                  );
                },
              ),
              //---------------------------------------------------------------
              ReusableOrderButton(
                text: 'T-shirt Orders',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TshirtOrders(),
                    ),
                  );
                },
              ),
              //--------------------------------------------------------------
              ReusableOrderButton(
                  text: 'Shield Orders',
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShieldOrders(),
                      ),
                    );
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
