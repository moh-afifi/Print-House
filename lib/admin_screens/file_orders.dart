import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../reusables/reusable_file_order_card.dart';

class FileOrders extends StatefulWidget {
  @override
  _FileOrdersState createState() => _FileOrdersState();
}

class _FileOrdersState extends State<FileOrders> {
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
    return  Scaffold(
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
          title: Text('Orders',style: TextStyle(fontSize: 25),),
        ),
        body: Column(
          children: <Widget>[
            //-------------------------------
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('file2').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blueAccent,
                      ),
                    );
                  }
                  final items = snapshot.data.documents;

                  List<ReusableFileOrderCard> itemElements = [];

                  for (final item in items) {
                    final myAddress = item.data['address'];
                    final myNumOfCopies = item.data['numOfCopies'];
                    final myPrintSize = item.data['printSize'];
                    final myPrintType = item.data['printType'];
                    final messageSender = item.data['sender'];
                    final fUrl = item.data['url'];

                    final itemElement = ReusableFileOrderCard(
                      sender: messageSender,
                      address: myAddress,
                      numOfCopies: myNumOfCopies,
                      printSize: myPrintSize,
                      printType: myPrintType,
                      fileUrl: fUrl,
                    );

                    itemElements.add(itemElement);
                  }
                  return Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                      children: itemElements,
                    ),
                  );
                }
            ),
            //-------------------------------
          ],
        )
    );
  }
}
