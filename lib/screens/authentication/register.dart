
import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';

import '../../shared/constants.dart';

class Register extends StatefulWidget {
  // const Register({Key? key}) : super(key: key);
  Function toggleView;
  Register({required this.toggleView});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey=GlobalKey<FormState>() ;
  final AuthService _auth=AuthService();
  bool loading=false;
  String error='',email='',pass='';
  @override
  Widget build(BuildContext context) {
    return loading?Spin: Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Sign up to Brew Crew"),
        backgroundColor: Colors.brown[700],
        actions: [
          TextButton.icon(onPressed:()async {widget.toggleView();}, icon: Icon(Icons.person), label:Text("Sign In")),
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
                child: Text("Register"),
                onPressed: ()async{if(_formkey.currentState!.validate()){
                  setState(() {
                    loading=true;
                  });
                  dynamic result = await _auth.reg(email, pass);
                  if(result==null){
                    error="Provide Proper Email and Password";
                    loading=false;
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



