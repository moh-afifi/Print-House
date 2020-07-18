import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:print5/reusables/reusable_shield_order_card.dart';

class ShieldOrders extends StatefulWidget {
  @override
  _ShieldOrdersState createState() => _ShieldOrdersState();
}

class _ShieldOrdersState extends State<ShieldOrders> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

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
      body: Column(
        children: <Widget>[
          //-------------------------------
          StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('shield').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blueAccent,
                    ),
                  );
                }
                final items = snapshot.data.documents.reversed;
                List<ReusableShieldOrderCard> itemElements = [];
                for (var item in items) {
                  final myAddress = item.data['address'];
                  final messageSender = item.data['sender'];
                 final myScrpt = item.data['script'];
                  final myMod = item.data['model'];

                  final itemElement = ReusableShieldOrderCard(
                    sender: messageSender,
                    address: myAddress,
                    model: myMod,
                    script: myScrpt,
                  );
                  itemElements.add(itemElement);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
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
