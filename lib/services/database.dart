import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/models/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseServices{
  final String? uid;
  DatabaseServices({ this.uid});
  final CollectionReference brewCollection =FirebaseFirestore.instance.collection("brews");
  Future updateUserData (String sugars,String name,int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars':sugars,
      'name':name,
      'strength':strength
    });
  }
  List<Brew> _fromListFromSnapshot(QuerySnapshot snap){
    return snap.docs.map((e) {
      return Brew(name: e['name']??'', sugars: e['sugars']??'0', strength: e['strength']??0);}
    ).toList();}


  UserData _userDatafromSnapshot(DocumentSnapshot e){
    print (e['name']);
    UserData a= UserData(sugars: e['sugars'], name: e['name'], strength: e['strength'], uid: e.id);
    print(a);
  return a;}


 Stream<List<Brew>> get brews{
    return brewCollection.snapshots()
    .map((event) => _fromListFromSnapshot(event));
  }
  Stream<UserData>get userData{
    // String path= '/brews/$uid';
    return brewCollection.doc(uid).snapshots()
        .map((e) {
      // var e = event.doc(uid);
      return _userDatafromSnapshot(e);
    });
  }
}