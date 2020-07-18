import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:print5/reusables/reusable_user_home_card.dart';
import 'gift.dart';
import 't_shirt.dart';
import 'file.dart';
import 'shield.dart';
import 'user_messages.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: GradientAppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.message),
              iconSize: 35,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserMessages(),
                  ),
                );
              }),
        ],
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 40,
          ),
        ),
        elevation: 0.0,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFFBF1215),
            Color(0xFF3A6186),
          ],
        ),
      ),
      //------------------------------------------------------------------
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ReusableUserHomeCard(
                label: 'Gifts',
                imagePath: 'images/coffee.png',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Gift(),
                    ),
                  );
                },
              ),
              ReusableUserHomeCard(
                label: 'T-shirt',
                imagePath: 'images/tshirt.png',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Tshirt(),
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ReusableUserHomeCard(
                label: 'Files',
                imagePath: 'images/file.png',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FilePrint(),
                    ),
                  );
                },
              ),
              ReusableUserHomeCard(
                label: 'shields',
                imagePath: 'images/shield.png',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Shield(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
