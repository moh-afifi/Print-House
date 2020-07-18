import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import '../reusables/reusable_card.dart';
import '../reusables/reusable_column.dart';
import 'package:print5/reusables/reusable_button.dart';
import 'package:print5/preview_models/model_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Shield extends StatefulWidget {
  @override
  _ShieldState createState() => _ShieldState();
}

class _ShieldState extends State<Shield> {
  String model = 'model: 1';
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String myScript;
  String myAddress;
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
      backgroundColor: Colors.grey[200],
      appBar: GradientAppBar(
        centerTitle: true,
        title: Text(
          'Shield',
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 40),
        ),
        elevation: 0.0,
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Color(0xFFBF1215), Color(0xFF3A6186)]),
      ),
      body: Builder(
        builder: (context) => ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Model(
                                  appBarTitle: 'Model One',
                                  modelUrl:
                                      "https://sketchfab.com/models/a9895985a23e426d93a7e24d4e733d8b/embed",
                                ),
                              ),
                            );
                          },
                          child: ReusableCard(
                            photo: Image(
                              image: AssetImage('images/model1.png'),
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Model: 1',
                          style: TextStyle(
                              color: Color(0xFFBF1215),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Model(
                                  appBarTitle: 'Model Two',
                                  modelUrl:
                                      "https://sketchfab.com/models/f40ccd7ab7f6468fadb1dfafbebc80f1/embed",
                                ),
                              ),
                            );
                          },
                          child: ReusableCard(
                            photo: Image(
                              image: AssetImage('images/model2.png'),
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Model: 2',
                          style: TextStyle(
                              color: Color(0xFFBF1215),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Model(
                                  appBarTitle: 'Model Three',
                                  modelUrl:
                                      "https://sketchfab.com/models/4c6f7e08df5f4444ab684eba682151f2/embed",
                                ),
                              ),
                            );
                          },
                          child: ReusableCard(
                            photo: Image(
                              image: AssetImage('images/model3.png'),
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Model: 3',
                          style: TextStyle(
                              color: Color(0xFFBF1215),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Choose Model:',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFBF1215),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: Text('chooose'),
                        value: model,
                        icon: Icon(Icons.keyboard_arrow_down),
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (String newValue) {
                          setState(() {
                            model = newValue;
                          });
                        },
                        items: <String>['model: 1', 'model: 2', 'model: 3']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ReusableColumn(
                  text: 'Enter script:',
                  textField: 'Enter Your Script ...',
                  onChanged: (value) {
                    myScript = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ReusableColumn(
                  text: 'Enter Your Address:',
                  textField: 'Enter Your Address...',
                  onChanged: (value) {
                    myAddress = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ReusableButton(
                  onTap: () {
                    _firestore.collection('shield').add({
                      'address': myAddress,
                      'sender': loggedInUser.email,
                      'model': model,
                      'script': myScript
                    });
                    Scaffold.of(context).showSnackBar(new SnackBar(
                      backgroundColor: Colors.teal,
                      duration: Duration(seconds: 3),
                      content: Row(
                        children: <Widget>[
                          Icon(
                            Icons.thumb_up,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Your Order has been sent!"),
                        ],
                      ),
                    ));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
