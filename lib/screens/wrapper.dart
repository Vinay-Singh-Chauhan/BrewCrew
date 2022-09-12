import 'package:brewcrew/screens/authentication/authenticate.dart';
import 'package:brewcrew/screens/authentication/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if(user==null){
      return Authenticate();
    }
    else{
      return Home();
    }
    return Authenticate();
  }
}
