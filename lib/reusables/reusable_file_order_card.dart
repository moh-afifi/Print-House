import 'package:flutter/material.dart';
import 'package:print5/admin_screens/admin_messgae.dart';
import '../components/download_file.dart';
class ReusableFileOrderCard extends StatelessWidget {
  ReusableFileOrderCard({this.sender, this.address,this.numOfCopies,this.printType,this.printSize,this.fileUrl});

  final String sender;
  final String address;
  final String numOfCopies;
  final String printSize;
  final String printType;
  final String fileUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(12),),
        elevation: 5.0,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'User: $sender',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black54,
                ),
              ),
              Text(
                'Address: $address',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15.0,
                ),
              ),
              Text(
                'Number Of Copies: $numOfCopies',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15.0,
                ),
              ),
              Text(
                'Print Size: $printSize',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15.0,
                ),
              ),
              Text(
                'Print Type: $printType',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15.0,
                ),
              ),
              IconButton(
                icon: Icon(Icons.message,size: 40,color: Colors.blueAccent,),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminMessage(customerName: sender,),
                    ),
                  );
                },
              ),
              DownloadFile(downloadUrl: fileUrl,)
            ],
          ),
        ),
      ),
    );
  }
}