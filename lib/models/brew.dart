import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
class Brew{
  String name='';
  String sugars='';
  int strength=0;
Brew({required this.name,required this.sugars, required this.strength});
}