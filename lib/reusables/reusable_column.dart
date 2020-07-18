import 'package:flutter/material.dart';

class ReusableColumn extends StatelessWidget {
  ReusableColumn({this.text,this.textField,this.onChanged});
  final String textField;
  final String text;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFFBF1215),
            ),
          ),
        ),
        //-----------------------------------------------
        TextField(
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: textField,
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged:onChanged ,
        ),
      ],);
  }
}
