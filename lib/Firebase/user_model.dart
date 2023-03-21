import 'package:cloud_firestore/cloud_firestore.dart';

class ChatUser {
  final _firestore = FirebaseFirestore.instance;

  final String id;
  final String full_Name;
  final String state;
  final String farmingType;
  final String farmingScale;
  final String needs;


  ChatUser(this.id, this.full_Name, this.state, this.farmingType, this.farmingScale, this.needs);

  factory ChatUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ){
    final data = snapshot.data();
    return ChatUser(
      data?['id'], 
      data?['full_Name'], 
      data?['state'] , 
      data?['farmingType'] , 
      data?['farmingScale'] , 
      data?['needs'] 
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) 'id': id,
      if (full_Name != null) 'full_Name': full_Name,
      if (state != null) 'state': state,
      if (farmingType != null) 'farmingType': farmingType,
      if (farmingScale != null) 'farmingScale': farmingScale,
      if (needs != null) 'needs': needs
    };
  }

  // final ref = _firestore.collection(collectionPath)
}