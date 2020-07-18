import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' ;
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  File _file;

//----------------------------------------
  Future filePicker() async {
    var file = await FilePicker.getFile(type: FileType.ANY);

    setState(() {
        _file = file;
        print('Image Path $_file');
      });
  }
  //-------------------------------------------------------

  Future uploadFile() async {
    String fileName = basename(_file.path);
    StorageReference storageReference;

    storageReference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = storageReference.putFile(_file);
    await uploadTask.onComplete;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Print House'),
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    child: Card(
                      elevation: 10.0,
                      child: Image(
                        image: AssetImage('images/camera1.png'),
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                  InkWell(
                    child: Icon(
                      Icons.camera_alt,
                      size: 50,
                    ),
                    onTap: () {
                      filePicker();
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Color(0xff476cfb),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  RaisedButton(
                    color: Color(0xff476cfb),
                    onPressed: () {
                      uploadFile();
                    },
                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
