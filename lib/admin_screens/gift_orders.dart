import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../reusables/reusable_gift_tshirt_order_card.dart';
import 'dart:ui';


class GiftOrders extends StatefulWidget {
  @override
  _GiftOrdersState createState() => _GiftOrdersState();
}

class _GiftOrdersState extends State<GiftOrders>  {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        centerTitle: true,
        title: Text('Gift Orders',style: TextStyle(fontSize: 25),),
      ),
      //-----------------------------------------------
      body: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('gift1').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blueAccent,
                    ),
                  );
                }
                final items = snapshot.data.documents.reversed;

                 List<ReusableGiftTshirtOrderCard> itemElements = [];

                for (final item in items) {
                  final myAddress = item.data['address'];
                  final myNumOfCopies = item.data['numOfCopies'];
                  final messageSender = item.data['sender'];
                  final imUrl = item.data['url'];

                  final itemElement = ReusableGiftTshirtOrderCard(
                    sender: messageSender,
                    address: myAddress,
                    numOfCopies: myNumOfCopies,
                    imageUrl: imUrl,
                  );
                  itemElements.add(itemElement);
                }
                return Expanded(
                  child: ListView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    children: itemElements,
                  ),
                );
              }),
          //-------------------------------
        ],
      ),
    );
  }
}


