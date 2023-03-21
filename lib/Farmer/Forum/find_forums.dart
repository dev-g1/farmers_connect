import 'package:farmers_connect/Farmer/Forum/aboutforum.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_connect/Farmer/Chat/chatting.dart';
import 'package:farmers_connect/Firebase/fire_auth.dart';
import 'package:farmers_connect/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FindForums extends StatefulWidget {
  const FindForums({super.key});

  @override
  State<FindForums> createState() => _FindForumsState();
}

class _FindForumsState extends State<FindForums> {
  final _firestore = FirebaseFirestore.instance;

  String user_Name = '';
   getUserInfo(){
    final db = _firestore.collection('Farmers').doc(FireAuth().currentUser!.uid);
    db.get().then(
      (DocumentSnapshot doc){
        if(doc.exists){
          final data = doc.data() as Map<String, dynamic>;

          setState(() {
            user_Name = data['username'];
          });

        }
      }
    );
  }


  String chatRoomId(String user1, String user2){
    if (user1[0].toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0]){
      return '$user1$user2';
    }else {
      return '$user2$user1';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }
  
  @override
  Widget build(BuildContext context) {
       return SafeArea(
         child: Scaffold(
          appBar: AppBar(
            title: Text('Search Forums', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),),
          backgroundColor: kColorPrimary,
            
          
            ),
          
           body: StreamBuilder(
               stream: _firestore.collection('Forums').snapshots(),
               builder: (context, snapshot){
             if (!snapshot.hasData) {
               return Center(
                 child: CircularProgressIndicator(color: kColorSecondary,),
               );
             }
             int itemCount = snapshot.data!.docs.length;
           return ListView.builder(
           shrinkWrap: true,
           itemCount: itemCount,
           itemBuilder: (context, index){
               DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                String forumTitle = documentSnapshot['Title'];
                String about = documentSnapshot['About'];
               
               return  ListTile(
               leading: CircleAvatar(radius: 25,
               backgroundColor: Colors.white,
               ),
               title: Text(forumTitle),
               subtitle:  Text( about) ,
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
               onTap: (){
                 Navigator.push(
                   context, MaterialPageRoute(builder: ((context) {
                     return AboutForum(var1: forumTitle, var2: about,);
                   })));
               },
             );
           }
               
           );
              }),
           ),
       );
  } 
}