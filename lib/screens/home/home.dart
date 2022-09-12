import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/screens/home/settings.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/services/database.dart';
import 'package:provider/provider.dart';
import 'brewlist.dart';

import 'brewlist.dart';
class Home extends StatefulWidget {
  // const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Set<Brew> a={Brew(name: "e",sugars: "e",strength: 10)};
  List<Brew> list=List<Brew>.empty() ;
  final AuthService _auth= AuthService();
  void _showSettings(){
    showModalBottomSheet(context: (context), builder: (context){
      return Settings();
    });
  }
  @override
  Widget build(BuildContext context) {
    var brewCollection;
    return StreamProvider<List<Brew>>.value(
      value: DatabaseServices().brews,
      initialData:list,
      child: Scaffold(
        backgroundColor: Colors.brown[40],
        appBar: AppBar(
          title:Text("home"),
          backgroundColor: Colors.brown[400],
          actions: [
            IconButton(onPressed: (){_auth.signOut();}, icon: Icon(
              Icons.person_remove,
              color: Colors.white,
            )),
            IconButton(onPressed: (){_showSettings();}, icon: Icon(Icons.settings)),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/coffee_bg.png'),
              fit: BoxFit.cover,
            )
          ),
            child: BrewList()),
      ),
    );
  }
}
