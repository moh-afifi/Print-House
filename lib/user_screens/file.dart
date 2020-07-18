import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import '../reusables/reusable_column.dart';
import 'package:print5/reusables/reusable_button.dart';
import 'package:print5/reusables/reusable_line.dart';
import '../reusables/reusable_add_line.dart';
import '../reusables/reusable_card.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class FilePrint extends StatefulWidget {
  @override
  _FilePrintState createState() => _FilePrintState();
}

class _FilePrintState extends State<FilePrint> {
  String printSize = 'A4';
  String printType = 'Black & white';
  bool showSpinner = false;
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;

  File _file;
  FirebaseUser loggedInUser;
  String myNumOfCopies;
  String myAddress;
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

  Future filePicker() async {
    var file = await FilePicker.getFile(type: FileType.ANY);

    setState(() {
      _file = file;
    });
  }
  //-------------------------------------------------------

  Future uploadFile(BuildContext context) async {
    String fileName = basename(_file.path);
    StorageReference storageReference;

    storageReference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = storageReference.putFile(_file);
    setState(() {
      showSpinner = true;
    });

    await uploadTask.onComplete;
    String downloadAddress = await storageReference.getDownloadURL();
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
            'files',
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ReusableCard(
                      photo: (_file != null)
                          ? Image.file(
                              _file,
                              fit: BoxFit.fill,
                            )
                          : Image(
                              image: AssetImage('images/file.png'),
                              height: 60,
                              width: 60,
                            ),
                    ),
//---------------------------------------------
                    ReusableAddLine(
                      onTap: () {
                        filePicker();
                      },
                      text: 'Add file',
                    ),
//-----------------------------------------
                    ReusableLine(
                      text:
                          (_file != null) ? basename(_file.path) : 'file name',
                      deleteFunction: () {
                        setState(() {
                          _file = null;
                        });
                      },
                    ),
//------------------------------------
                    ReusableColumn(
                      onChanged: (value) {
                        myNumOfCopies = value;
                      },
                      text: 'Number of copies: ',
                      textField: 'Enter Number of copies ...',
                    ),
//------------------------------------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Print Size:',
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
                            value: printSize,
                            icon: Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (String newValue) {
                              setState(() {
                                printSize = newValue;
                              });
                            },
                            items: <String>['A4', 'A3']
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
//-----------------------------------------------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Print Type:',
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
                            value: printType,
                            icon: Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (String newValue) {
                              setState(() {
                                printType = newValue;
                              });
                            },
                            items: <String>['Black & white', 'colorful']
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
//-----------------------------------------------
                    ReusableColumn(
                      onChanged: (value) {
                        myAddress = value;
                      },
                      text: 'Your Address: ',
                      textField: 'Enter your address ...',
                    ),
//-----------------------------------------------
                    ReusableButton(
                      onTap: () async {

                        await uploadFile(context);

                        _firestore.collection('file2').add({
                          'printSize': printSize,
                          'printType': printType,
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
        ),
      ),
    );
  }
}
