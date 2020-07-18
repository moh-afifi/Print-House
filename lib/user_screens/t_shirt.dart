import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../reusables/reusable_column.dart';
import 'package:print5/reusables/reusable_button.dart';
import 'package:print5/reusables/reusable_line.dart';
import '../reusables/reusable_add_line.dart';
import '../reusables/reusable_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Tshirt extends StatefulWidget {
  @override
  _TshirtState createState() => _TshirtState();
}

class _TshirtState extends State<Tshirt> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  File _image;
  FirebaseUser loggedInUser;
  String myNumOfCopies;
  String myAddress;
  bool showSpinner = false;
  String downloadUrl;
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

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future uploadPic(BuildContext context) async {
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    setState(() {
      showSpinner = true;
    });
    await uploadTask.onComplete;
    String downloadAddress = await firebaseStorageRef.getDownloadURL();
    downloadUrl = downloadAddress;
    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: GradientAppBar(
            centerTitle: true,
            title: Text(
              'T-shirt',
              style:
                  TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 40),
            ),
            elevation: 0.0,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFFBF1215), Color(0xFF3A6186)]),
          ),
          body: Builder(
            builder: (context) => Padding(
              padding: EdgeInsets.all(15.0),
              child: ListView(
                children: <Widget>[
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ReusableCard(
                        photo: (_image != null)
                            ? Image.file(
                                _image,
                                fit: BoxFit.fill,
                              )
                            : Image(
                                image: AssetImage('images/add.png'),
                                width: 60,
                                height: 60,
                              ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      //---------------------------------------------
                      ReusableAddLine(
                        onTap: () {
                          getImage();
                        },
                        text: (_image != null)
                            ? basename(_image.path)
                            : 'file name',
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      //-----------------------------------------
                      ReusableLine(
                        text: (_image!=null)? basename(_image.path) :'file name',
                        deleteFunction: () {
                          setState(() {
                            _image = null;
                          });
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      //------------------------------------
                      ReusableColumn(
                        onChanged: (value) {
                          myNumOfCopies = value;
                        },
                        text: 'Number of copies: ',
                        textField: 'Enter Number of copies ...',
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      //-----------------------------------------------
                      ReusableColumn(
                        onChanged: (value) {
                          myAddress = value;
                        },
                        text: 'Your Address: ',
                        textField: 'Enter your address ...',
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      //-----------------------------------------------
                      ReusableButton(
                        onTap: () async{
                          await uploadPic(context);
//                        downloadImage();
                          print(downloadUrl);
                          _firestore.collection('tshirt1').add({
                            'address': myAddress,
                            'numOfCopies': myNumOfCopies,
                            'sender': loggedInUser.email,
                            'url': downloadUrl
                          });
                          Scaffold.of(context).showSnackBar(new SnackBar(
                            backgroundColor: Colors.teal,
                            duration: Duration(seconds: 3),
                            content: Row(
                              children: <Widget>[
                                Icon(Icons.thumb_up,),
                                SizedBox(width: 20,),
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
          )),
    );
  }
}
