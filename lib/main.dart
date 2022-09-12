import 'package:brewcrew/screens/authentication/signIn.dart';
import 'package:brewcrew/screens/wrapper.dart';
import 'package:brewcrew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
//
//   runApp(MaterialApp(
//     home:SignIn(),
//   ));
// }
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value:AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
// class home extends StatelessWidget {
//   const home({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     return SignIn();
//   }
// }
