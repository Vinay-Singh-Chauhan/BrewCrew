// import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/services/database.dart';
import'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //anonymousSignIn
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get user{
    return _auth.userChanges();
  }
  // Stream<User?> get cuser{
  //   return _auth.currentUser;
  // }
  // Future<dynamic> signInAnon() async {
  //   try {
  //   dynamic result = await _auth.signInAnonymously();
  //   User? user = result.user;
  //   // print(user);
  //   return result;
  // }catch(e){
  //   print(e.toString());
  //   return null;
  //   }
  // }

  //RegWithEmailPass
  Future <User?>reg(String email,String pass)async{
    try{
      dynamic result = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      String name=_auth.currentUser!.uid;
      await DatabaseServices(uid:name).updateUserData('0','Enter Your Name Here',100);

      return result;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  //signOut
  Future signOut() async {
    try{
    _auth.signOut();
    }
    catch(e){
      print(e.toString());
    }
  }
  //signInEmailPass
  Future <dynamic>signIn(String email,String pass)async{
    try{
      dynamic result = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return result;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}