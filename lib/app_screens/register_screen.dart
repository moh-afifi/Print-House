import 'package:flutter/material.dart';
import 'package:print5/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:print5/user_screens/user_home.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:print5/components/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;
  final bloc = Bloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Register",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        body: Builder(
          builder: (context) => ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: ListView(
                padding: EdgeInsets.all(20),
                children: <Widget>[
                  Image(
                    image: AssetImage('images/logo.png'),
                    height: 300,
                    width: 200,
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  StreamBuilder<String>(
                    stream: bloc.email,
                    builder: (context, snapshot) => TextField(
                      onChanged: bloc.emailChanged,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter email",
                          labelText: "Email",
                          errorText: snapshot.error),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  StreamBuilder<String>(
                    stream: bloc.password,
                    builder: (context, snapshot) => TextField(
                      onChanged: bloc.passwordChanged,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter password",
                          labelText: "Password",
                          errorText: snapshot.error),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RoundedButton(
                    title: 'Register',
                    colour: Colors.blueAccent,
                    onPressed: () async {
                      var connectivityResult = await (Connectivity().checkConnectivity());

                      setState(() {
                        showSpinner = true;
                      });
                      try{
                        final newUser = await _auth.createUserWithEmailAndPassword(
                            email: bloc.getEmail,
                            password: bloc.getPassword);
                        if ((newUser != null)||(connectivityResult == ConnectivityResult.mobile)||(connectivityResult == ConnectivityResult.wifi)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserHome(),
                            ),
                          );
                        }
                      }catch(e){
                        setState(() {
                          showSpinner = false;
                        });
                        if(e is PlatformException){
                          if (e.code== 'ERROR_EMAIL_ALREADY_IN_USE'){
                            Scaffold.of(context).showSnackBar(new SnackBar(
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3),
                              content: Text("Email alredy exists !"),
                            ));
                          }else{
                            Scaffold.of(context).showSnackBar(new SnackBar(
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3),
                              content: Text("Please enter email and passowrd"),
                            ));
                          }
                        }
                        if((connectivityResult != ConnectivityResult.mobile)&&(connectivityResult != ConnectivityResult.wifi)){
                          setState(() {
                            showSpinner = false;
                          });
                          Scaffold.of(context).showSnackBar(new SnackBar(
                            backgroundColor: Colors.black,
                            duration: Duration(seconds: 3),
                            content: Text("No internet Connection !",style: TextStyle(fontSize: 17),),
                          ));
                        }
                        else if(bloc.getEmail == null || bloc.getPassword == null){
                          Scaffold.of(context).showSnackBar(new SnackBar(
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 3),
                            content:
                            Text("Please, Enter email and passowrd!",style: TextStyle(fontSize: 17),),
                          ));
                        }
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    },
                  ),
                ],
              )),
        ));
  }
}