import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon, @required this.onPressed});

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0.0,
      child: Icon(icon,color: Colors.white,),
      onPressed: onPressed,
      constraints: BoxConstraints.tightFor(
        width: 25.0,
        height: 25.0,
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFFBF1215),
    );
  }
}