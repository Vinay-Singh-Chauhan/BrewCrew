import 'package:flutter/material.dart';
import'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../models/brew.dart';
import 'brewtile.dart';
class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {

  @override
  Widget build(BuildContext context) {
    final brews =Provider.of<List<Brew>>(context);
    return ListView.builder(
        itemCount:brews.length,
        itemBuilder: (context,index){
      return BrewTile(brew: brews[index]);
    });
  }
}
