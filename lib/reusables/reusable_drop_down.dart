import 'package:flutter/material.dart';

class ReusableDropDown extends StatelessWidget {
  ReusableDropDown({this.value,this.setFunction,this.text});
  final String text;
  final String value;
  final Function setFunction;
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
        Padding(
          padding: EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text('chooose'),
            value: value,
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 24,
            elevation: 16,
            onChanged: (String newValue) {
              setFunction();
            },
            items:  <String>['1','2','3','4'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
