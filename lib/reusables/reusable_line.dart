import 'package:flutter/material.dart';

class ReusableLine extends StatelessWidget {
  ReusableLine({this.text,this.deleteFunction});
  final String text;
final Function deleteFunction;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage('images/pick_image.png'),
                  height: 25,
                  width: 25,
                ),
              ),
              Text(
                text,
                style: TextStyle(fontSize: 20),
              ),
          InkWell(
            onTap: deleteFunction,
            child: Image(
              image: AssetImage('images/delete.png'),
              height: 25,
              width: 25,
            ),
          ),
          //------------------------------------

        ],
      ),
    );
  }
}