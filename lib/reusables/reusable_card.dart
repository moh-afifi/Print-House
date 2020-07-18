import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({this.photo});
  final Widget photo;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        child: Card(
          elevation: 12.0,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: photo
          ),
        ),
      ),
    );
  }
}
