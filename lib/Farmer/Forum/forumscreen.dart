import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_connect/Farmer/Chat/chatting.dart';
import 'package:farmers_connect/Firebase/fire_auth.dart';
import 'package:farmers_connect/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


class ForumScreen extends StatefulWidget {
   ForumScreen({super.key, required this.var1, required this.var2});
  String var1;
  String var2;

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {

  final _firestore = FirebaseFirestore.instance;
  final userId = FireAuth().currentUser!.uid;

  TextEditingController messageController = TextEditingController();

  String current_userName = '';
  getUserInfo(){
    final db = _firestore.collection('Farmers').doc(FireAuth().currentUser!.uid);
    db.get().then(
      (DocumentSnapshot doc){
        if(doc.exists){
          final data = doc.data() as Map<String, dynamic>;

          setState(() {
            current_userName = data['username'];
            // current_user_Id = data['id'];
            // current_user_Name = data['username'];

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
  String forumTitle = widget.var1;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kColorPrimary,
          title: Text(forumTitle),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder(
              stream: _firestore.collection('Forums/$forumTitle/messages').orderBy('created at', descending: true).snapshots(),
              builder: ((context, snapshot) {
                
                int itemCount = snapshot.data!.docs.length;
                return Expanded(
                  child: ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            itemCount: itemCount,
                            itemBuilder: (context, index){
                          
                  DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                  String userName = documentSnapshot['username'] ?? '';
                  String messageType = documentSnapshot['type'] ?? '';
                  
                  if (!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(color: kColorPrimary,),
                    );
                  }
                  
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 7.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: (documentSnapshot['id'] == userId ?  Alignment.topRight : Alignment.topLeft),
                            child: messageType == 'text' ? 
                            Container(
                              width: MediaQuery.of(context).size.width *0.6,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (documentSnapshot['id'] == userId  ? kColorPrimary : kColorSecondary )
                              ),
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PopupMenuButton(
                                    onSelected: (value) {
                                      Navigator.push(context, MaterialPageRoute(builder: ((context) {
                                          String roomId = chatRoomId(current_userName, userName);
                                        return ChattingScreen(var1: userName, var2: documentSnapshot['id'], var3: roomId);
                                      })));
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        height: kMinInteractiveDimension,
                                        value: 1,
                                        child: Text('Message $userName'))
                                    ],
                                    child: Text( documentSnapshot['username'], style: TextStyle(fontWeight: FontWeight.w600, color: (documentSnapshot['id'] == userId  ? Colors.white : kColorPrimary )), )),
                                  SizedBox(height: 5,),
                                  Text(documentSnapshot['message'], style: TextStyle(fontWeight: FontWeight.w400, color: (documentSnapshot['id'] == userId  ? Colors.white : kColorPrimary ))),
    
                                ],
                              )
                                  
                              )
    
                              :
    
                              Container(
                              width: MediaQuery.of(context).size.width *0.6,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (documentSnapshot['id'] == userId  ? kColorPrimary : kColorSecondary )
                              ),
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PopupMenuButton(
                                    onSelected: (value) {
                                      Navigator.push(context, MaterialPageRoute(builder: ((context) {
                                          String roomId = chatRoomId(current_userName, userName);
                                        return ChattingScreen(var1: userName, var2: documentSnapshot['id'], var3: roomId);
                                      })));
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        height: kMinInteractiveDimension,
                                        value: 1,
                                        child: Text('Message $userName'))
                                    ],
                                    child: Text( documentSnapshot['username'], style: TextStyle(fontWeight: FontWeight.w600, color: (documentSnapshot['id'] == userId  ? Colors.white : kColorPrimary )), )),
                                  SizedBox(height: 5,),
                                  // Text(documentSnapshot['message'], style: TextStyle(fontWeight: FontWeight.w400, color: (documentSnapshot['id'] == userId  ? Colors.white : kColorPrimary ))),
                                  Image.network(documentSnapshot['message'])
                                ],
                              )
                                  
                              )
                          ),
                                SizedBox(
                                  child: Align(
                                    alignment: (documentSnapshot['id'] == userId ? Alignment.bottomRight : Alignment.bottomLeft),
                                    child: Text (documentSnapshot['time'], style: TextStyle(fontSize: 14), textAlign: documentSnapshot['id'] == userId ? TextAlign.left : TextAlign.right ,)),
                                )
                        ],
                      ),
                    );
                            }),
                );
                })),
        
          SendMessage(
            (){
              if (messageController.text != '') {
                
              final message = <String, dynamic>{
                  'username' : current_userName,
                  'message': messageController.text,
                  'id' : userId,
                  'time': DateFormat('HH:mm a').format(DateTime.now()),
                  'created at' : Timestamp.now().toDate().toString(),
                  'type' : 'text'
                };
                 _firestore.collection('Forums/$forumTitle/messages').add(message);
    
                _firestore.collection('MyForums/$forumTitle/messages').doc(current_userName).set(
                    {
                        'username': current_userName,
                        'id': userId,
                        'time' : DateFormat('HH:mm a').format(DateTime.now()),
                        'message' : messageController.text,
                        'forumTitle' :forumTitle,
                        'type' : 'text'
                    }
                    , SetOptions(merge: true)
                  );
                
                messageController.text = '';
              }
                
                }, messageController, forumTitle, userId)
            
        
            
          
          ],
        ),
      ),
    );
  }
}