
import 'dart:io';

import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_connect/Farmer/mylists.dart';
import 'package:farmers_connect/Firebase/fire_auth.dart';
import 'package:farmers_connect/REO/mylists2.dart';
import 'package:farmers_connect/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

MyLists myLists = MyLists();
class ChattingScreen extends StatefulWidget {
   ChattingScreen(  {required this.var1, required this.var2, required String this.var3});
  final var1;
  final var2;
  final var3;

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {

  final _firestore = FirebaseFirestore.instance;
  final _fireStorage = FirebaseStorage.instance;
  final cid = FireAuth().currentUser!.uid;

  TextEditingController messageController = TextEditingController();

  File? _photo;
  final ImagePicker _picker = ImagePicker();
  

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected');
      }
    });

  }
  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected');
      }
    });

  }
  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = _fireStorage.ref(destination).child('file/');
      await ref.putFile(_photo!);
    } catch (e) {
      print(e);
    }
  }

  String current_user_Name = '';

  getUserInfo(){
    final db = _firestore.collection('Farmers').doc(FireAuth().currentUser!.uid);
    db.get().then(
      (DocumentSnapshot doc){
        if(doc.exists){
          final data = doc.data() as Map<String, dynamic>;

          setState(() {
            current_user_Name = data['username'];
            // current_user_Id = data['id'];
            // current_user_Name = data['username'];

          });

        }
      }
    );
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }
  
  @override
  Widget build(BuildContext context) {
    final userName = widget.var1;
    final uid = widget.var2;
    final roomId = widget.var3;

   
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
                 padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(9, 178, 77, 1),
                      Color.fromRGBO(150, 201, 61, 1)
      
                    ])
                  ),
            
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      icon: Icon(Icons.arrow_back_ios_new, color: Colors.white,),
                      ),
      
                    SizedBox(width: 5,),
                    CircleAvatar(
                      backgroundImage: AssetImage(''),
                      radius: 20,
                    ),
                    SizedBox(width: 10,),
                    Text(userName, style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),)
      
                  ],
                ),
      
                      
                  
          ),
        ),
        
        body: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ 
            StreamBuilder(
              stream: _firestore.collection('Chats/$roomId/chats').orderBy('created at', descending: true).snapshots(),
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
                  final messageType = documentSnapshot['type'];
                  
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
                            alignment: (documentSnapshot['id'] == uid ? Alignment.topLeft : Alignment.topRight),
                            child: messageType == 'text' ?  
                            Container(
                              width: MediaQuery.of(context).size.width *0.6,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (documentSnapshot['id'] == uid  ? kColorSecondary:Color.fromRGBO(73, 214, 80, 1))
                              ),
                              child:
                                  Text(documentSnapshot['message'] ?? ''),
                                
                              )
        
                              :
        
                              Container(
                              width: MediaQuery.of(context).size.width *0.6,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (documentSnapshot['id'] == uid  ? kColorSecondary:Color.fromRGBO(73, 214, 80, 1))
                              ),
                              child:
                                  Image.network(documentSnapshot['message'] ?? ''),
                                  // Text(documentSnapshot['message'] ?? ''),
                                
                              ),
                          ),
                                SizedBox(
                                  child: Align(
                                    alignment: (documentSnapshot['id'] == uid ? Alignment.bottomLeft : Alignment.bottomRight),
                                    child: Text (documentSnapshot['time'] ?? '', style: TextStyle(fontSize: 14), textAlign: documentSnapshot['id'] == uid ? TextAlign.left : TextAlign.right ,)),
                                )
                        ],
                      ),
                    );
        
                    
                            }),
                );
                })),
        
        
        
            SendMessage((){
              if (messageController.text != '')
              {final message = <String, dynamic>{
                  'message': messageController.text,
                  'username' : current_user_Name,
                  'id' : cid,
                  'time': DateFormat('HH:mm a').format(DateTime.now()),
                  'created at' : Timestamp.now().toDate().toString(),
                  'type' : 'text'
                };
                //  _firestore.collection('/Forums/$forumName/messages').add(message);
                _firestore.collection('Chats/$roomId/chats').add(message);
            
                _firestore.collection('Chatting/$uid/chatting').doc(current_user_Name).set(
                  
                  {
                      'username': current_user_Name,
                      'id': cid,
                      'time' : DateFormat('HH:mm a').format(DateTime.now()),
                      'message' : messageController.text
                  }
                  , SetOptions(merge: true)
                );
                _firestore.collection('Chatting/$cid/chatting').doc(userName).set(
                  
                  {
                      'username': userName,
                      'id': uid,
                      'time' : DateFormat('HH:mm a').format(DateTime.now()),
                      'message' : messageController.text
                  }
                  , SetOptions(merge: true)
                );}
                 
                
        
            
                messageController.text = '';
            }, 
            messageController, roomId, current_user_Name)
            
        
            
          ],
        )
      ),
    );
  }

}

class SendMessage extends StatefulWidget {
  
   SendMessage(this.onPressed, this.controller, this.storeLocation, this.current_user_Name);
  void Function() onPressed;
  TextEditingController controller;
  final storeLocation;
  String current_user_Name;

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
   final _firestore = FirebaseFirestore.instance;
  final _fireStorage = FirebaseStorage.instance;
  final cid = FireAuth().currentUser!.uid;
  
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected');
      }
    });

  }
  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected');
      }
    });

  }
  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';
    final storeLocation = widget.storeLocation;

    

    try {
      final ref = _fireStorage.ref(destination).child('file/');
      //  await ref.putFile(_photo!);
      final String imageUrl = await ref.getDownloadURL();

   
      await _firestore.collection('Chats/$storeLocation/chats').add(
        {
             'username' : widget.current_user_Name,
              'id' : cid,
              'time': DateFormat('HH:mm a').format(DateTime.now()),
              'created at' : Timestamp.now().toDate().toString(),
              'type' : 'image',
              'message' : imageUrl
        }
      );


    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    
    TextEditingController messageController = TextEditingController();
    return Container(
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kColorPrimary,
            blurRadius: 3,
            blurStyle: BlurStyle.outer,
            spreadRadius: 1,
          )
        ]
      ),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: (){
              showModalBottomSheet(
                context: context, 
                builder: (BuildContext bc){
                  return SafeArea(
                    child: Wrap(
                      children: [
                        ListTile(
                          leading: Icon(Icons.photo_library),
                          title: Text('Gallery'),
                          onTap: (){
                            imgFromGallery();
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.photo_camera),
                          title: Text('Camera'),
                          onTap: (){
                            imgFromCamera();
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ));
                });
            },
            child: Icon(Icons.photo)),
          
           Expanded(
             child: Container(
               child: TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: 'Message',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none
                  )
                )),
             )
           ),
              
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, right: 10),
            child: GestureDetector(
              onTap: widget.onPressed,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: kColorPrimary,
                ),
                  child: Icon(Icons.send_rounded, color: Colors.white,)
               ),
            ),
          ),
        ],
      ),
    );
  }
}