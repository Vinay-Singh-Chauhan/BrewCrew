import 'package:brewcrew/screens/authentication/register.dart';
import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:flutter/material.dart';

import '../../shared/loading.dart';

class SignIn extends StatefulWidget {
  // const SignIn({Key? key}) : super(key: key);
   Function toggleView ;
  SignIn({required this.toggleView});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formkey=GlobalKey<FormState>();
  final AuthService _auth=AuthService();
  bool loading=false;
  String email='',pass='',error='';
  @override
  Widget build(BuildContext context) {
    // Firebase.initializeApp();
    return loading?Spin:Scaffold(

    backgroundColor: Colors.brown[100],
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Sign in to Brew Crew"),
        backgroundColor: Colors.brown[700],
        actions: [
          TextButton.icon(onPressed:()async {widget.toggleView();}, icon: Icon(Icons.person_add), label:Text("Register")),
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 20.0),
          child: Form( key:_formkey,
              child: Column(children: [
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText:"Email"),
                  validator: (val){ return val!.isEmpty?'Enter valid E-Mail': null;},
                  onChanged: (val){
                    setState(() {
                      email=val;
                    });
                  },
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText:"Password"),
                  obscureText: true,
                  validator: (val){return  val!.isEmpty?'Enter Password': null;},
                  onChanged: (val){
                    setState(() {
                      pass=val;
                    });
                  },
                ),
                ElevatedButton(
                  child: Text("Sign In"),
                  onPressed: ()async{if(_formkey.currentState!.validate()){
                    setState(() {
                      loading=true;
                    });
                    dynamic result = await _auth.signIn(email, pass);
                    if(result==null){
                      setState(() {
                        error="Provide Proper Email And Password";
                        loading=false;
                      });
                    }
                  };},
                ),
                SizedBox(height: 20.0,),
                Text(
                  "$error",
                  style : TextStyle(
                    fontSize: 14.0,
                    color: Colors.red,
                  )
                )
              ],)
          )
        ),
    );
  }
}
