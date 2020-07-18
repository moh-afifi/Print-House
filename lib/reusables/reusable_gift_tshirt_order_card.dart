import 'package:flutter/material.dart';
import 'package:print5/admin_screens/admin_messgae.dart';
import 'dart:ui';
import 'package:print5/components/download_file.dart';

class ReusableGiftTshirtOrderCard extends StatefulWidget {
  ReusableGiftTshirtOrderCard(
      {this.sender, this.address, this.numOfCopies, this.imageUrl});
  final String sender, address, numOfCopies, imageUrl;

  @override
  _ReusableGiftTshirtOrderCardState createState() =>
      _ReusableGiftTshirtOrderCardState();
}

class _ReusableGiftTshirtOrderCardState extends State<ReusableGiftTshirtOrderCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        elevation: 5.0,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'User: ${widget.sender}',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black54,
                ),
              ),
              Text(
                'Address: ${widget.address}',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15.0,
                ),
              ),
              Text(
                'Number Of Copies: ${widget.numOfCopies}',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15.0,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.message,
                  size: 40,
                  color: Colors.blueAccent,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminMessage(
                        customerName: widget.sender,
                      ),
                    ),
                  );
                },
              ),
              //---------------------------------------------------------------
              DownloadFile(downloadUrl: widget.imageUrl,)
              //---------------------------------------------------------------
            ],
          ),
        ),
      ),
    );
  }
}
