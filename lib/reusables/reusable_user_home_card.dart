import 'package:flutter/material.dart';

class ReusableUserHomeCard extends StatelessWidget {
  ReusableUserHomeCard({this.imagePath,this.label,this.onTap});
  final String imagePath;
  final String label;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap:onTap,
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image(
                  image: AssetImage(imagePath),
                  height: 100,
                  width: 100,
                ),
              ),
              elevation: 12.0,
            ),
          ),
        ),
        Text(label,
          style: TextStyle(
            color: Color(0xFFBF1215),
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
