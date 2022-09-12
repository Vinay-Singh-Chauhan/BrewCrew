import 'package:brewcrew/models/userdata.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brewcrew/services/auth.dart';
class Settings extends StatefulWidget {
  // const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey=GlobalKey<FormState>();
  final List<String> sugars=['0','1','2','3','4'];
  String? _currentSugars;
  String? _currentName;
  int? _currentStrength;
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    // final UserData data=Provider.of<UserData>context;
    // UserData? userData = Provider.of<UserData>(context);
    // Provider.of<User?>(context);
    // print(user);
     {
      return StreamBuilder<UserData?>(

      stream: DatabaseServices(uid: user.uid.toString()).userData,
      builder: (context,e){
        if(e.hasData){
          print("yes");
          UserData? userData=e.data;
          // _currentSugars=userData!.sugars;
          // _currentName='Enter Your Name';
          // _currentStrength=100;
          print(userData);
        return Container(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: Form(
          key:_formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: userData!.name,
                validator: (val){return val!.isEmpty ?'Please Enter a name':null;},
                onChanged: (val){setState(() {
                _currentName=val;
                });
                },
              ),
              DropdownButtonFormField(
                  value:_currentSugars??userData.sugars,
                  items: sugars.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: new Text("$e sugars")
                  );
                  }).toList(),
                  onChanged: (value){setState(() =>
                  _currentSugars=value.toString()
);
}),
              Slider(min: 100.0,max: 900.0,divisions: 8, value: (_currentStrength??userData.strength).toDouble(),activeColor: Colors.brown[_currentStrength??userData.strength],inactiveColor: Colors.brown[_currentStrength??userData.strength], onChanged: (val){setState(() {
  _currentStrength=val.toInt();
});
}),
              ElevatedButton(onPressed: ()async{
                if(_formKey.currentState!.validate()){
                  await DatabaseServices(uid:user.uid).updateUserData(_currentSugars??userData.sugars,_currentName??userData.name,_currentStrength??userData.strength);
                Navigator.pop(context);}
              }, child: Text("Update"))
            ],
          ),
        ),
      );
      }
        else{
          // print("no");
          return  Text("hello");
        }
      }

    );
    }
  }
}
