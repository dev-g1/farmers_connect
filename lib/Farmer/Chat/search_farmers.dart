import 'package:intl/date_symbol_data_local.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_connect/Farmer/Chat/chatting.dart';
import 'package:farmers_connect/Firebase/fire_auth.dart';
import 'package:farmers_connect/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SearchUsers extends StatefulWidget {
  const SearchUsers({super.key});

  @override
  State<SearchUsers> createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
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

  // String user_Name2 = '';
  //  getUserInfo2(){
  //   final db = _firestore.collection('REO').doc(FireAuth().currentUser!.uid);
  //   db.get().then(
  //     (DocumentSnapshot doc){
  //       if(doc.exists){
  //         final data = doc.data() as Map<String, dynamic>;

  //         setState(() {
  //           user_Name2 = data['username'];
  //         });

  //       }
  //     }
  //   );
  // }

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
    // getUserInfo2();
  }
  
  @override
  Widget build(BuildContext context) {
       return DefaultTabController(
         initialIndex: 0,
         length:2,
         child: Scaffold(
          appBar: AppBar(
            title: Text('Search Users', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),),
          backgroundColor: Color(0xFF03341c),
          bottom: TabBar(tabs: 
                      [
                        Tab(text: 'Farmers',),
                        Tab(text: 'REO',)
                      ]
                      ),   
          
            ),
          
           body: TabBarView(
             children: [
                StreamBuilder(
                    stream: _firestore.collection('Farmers').snapshots(),
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
                  String user = documentSnapshot['user?'];
                  
                    
                    if (user == 'Farmer' ) {
                      
                    
                    return  ListTile(
                    leading: CircleAvatar(radius: 25,),
                    title: Text(documentSnapshot['username']),
                    subtitle:  Text( documentSnapshot['state']+ ' , ' + documentSnapshot['farming_type'] + ' farming') ,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    onTap: (){
                      String roomId = chatRoomId(user_Name, documentSnapshot['username']);
                      Navigator.push(
                        context, MaterialPageRoute(builder: ((context) {
                          return ChattingScreen(var1: documentSnapshot['username'], var2: documentSnapshot['id'], var3: roomId,);
                        })));
                    },
                  );
                }
                    
                });
                                    }),

            Container(
              child: StreamBuilder(
                stream: _firestore.collection('REO').snapshots(),
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
                      String nameOfUser = documentSnapshot['username'];
                      String userExpertise = documentSnapshot['expertise'];
                      String userExperience = documentSnapshot['experience'];
                      
                      return  ListTile(
                      leading: CircleAvatar(radius: 25,
                      backgroundColor: Colors.white,
                      ),
                      title: Text(nameOfUser),
                      subtitle:  Text( userExpertise + '  , ' + userExperience) ,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      onTap: (){
                        String roomId = chatRoomId(user_Name, nameOfUser);
                        Navigator.push(
                          context, MaterialPageRoute(builder: ((context) {
                            return ChattingScreen(var1: nameOfUser, var2: documentSnapshot['id'], var3: roomId,);
                          })));
                      },
                    );
                      
                  });
              }),
            ),
         
                      ]
                    ),
           ),
         
       
       );
  }
}