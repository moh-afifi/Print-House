import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:print5/reusables/reusable_button.dart';

class AdminMessage extends StatefulWidget {
  AdminMessage({this.customerName});
  final customerName;
  @override
  _AdminMessageState createState() => _AdminMessageState();
}

class _AdminMessageState extends State<AdminMessage> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String myMessage;
  //String myToUser;

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
        centerTitle: true,
        title: Text('Admin Messsge'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                //-----------------------------------------
                SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    myMessage = value;
                  },
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'enter your message..',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                //-----------------------------------------
                SizedBox(
                  height: 20,
                ),
                ReusableButton(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Center(
                            child: Text(
                          'Done!',
                          style: TextStyle(color: Colors.teal),
                        )),
                        content: Text(
                          'Your message has been sent successfully !',
                          style: TextStyle(fontSize: 15),
                        ),
                        elevation: 8.0,
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'OK !',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    );
                    _firestore.collection('admin').add({
                      'toUser': widget.customerName,
                      'message': myMessage,
                      'sender': loggedInUser.email,
                    });
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
