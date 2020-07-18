import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:io';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  File _image;

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async{
      String fileName =  basename(_image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      await uploadTask.onComplete;
      setState(() {
        print("Profile Picture uploaded");
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Print House'),
        backgroundColor: Colors.teal,
      ),
      body: Builder(builder: (context)=>Padding(
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
                    child:(_image!=null)?Image.file(
                      _image,
                      fit: BoxFit.fill,
                    ):Image(
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
                    getImage();
                  },
                ),
              ],
            ),
            //1Text(),
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
                    uploadPic(context);
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
      )
      ),
    );
  }
}
