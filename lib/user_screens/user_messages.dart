import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../reusables/message_bubble_user.dart';
import 'package:print5/admin_screens/admin_messgae.dart';
class UserMessages extends StatefulWidget {


  @override
  _UserMessagesState createState() => _UserMessagesState();
}

class _UserMessagesState extends State<UserMessages> {
   AdminMessage myAdminMessage = AdminMessage();
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
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        centerTitle: true,
        title: Text('User Messages'),
      ),
      body: Column(
        children: <Widget>[
          //-------------------------------
          StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('admin').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blueAccent,
                    ),
                  );
                }
                final items = snapshot.data.documents.reversed;
                List<ReusableUserMsgCard> itemElements = [];
                for (var item in items) {
                  final myMessage = item.data['message'];
                   final myToUser = item.data['toUser'];
                  final messageSender = item.data['sender'];

                  final itemElement = ReusableUserMsgCard(
                    sender: messageSender,
                    message: myMessage,
                  );
                  if(loggedInUser.email == myToUser){
                    itemElements.add(itemElement);
                  }
                }
                return Expanded(
                  child: ListView(
                    //reverse: true,
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
