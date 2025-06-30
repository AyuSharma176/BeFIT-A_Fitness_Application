import 'package:befit/main.dart';
import 'package:befit/pages/Login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<StatefulWidget> createState() => _WrapperState();

}

class _WrapperState extends State<Wrapper>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return HomeScreen();
            }
            else{
              return SignInScreen();
            }
          }
      ),
    );
  }

}