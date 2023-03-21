import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_connect/Common%20Pages/welcomescreen.dart';
import 'package:farmers_connect/Common%20Pages/widgets/conversationList.dart';
import 'package:farmers_connect/Farmer/Chat/chatting.dart';
import 'package:farmers_connect/Farmer/Chat/search_farmers.dart';
import 'package:farmers_connect/Farmer/Forum/my_forums.dart';
import 'package:farmers_connect/Farmer/mylists.dart';
import 'package:farmers_connect/Firebase/fire_auth.dart';
import 'package:farmers_connect/Profiles/farmer_profile.dart';
import 'package:farmers_connect/constants.dart';
import 'package:farmers_connect/models/chatUsersModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


MyLists myLists = MyLists();
class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String current_user_Name = '';
  String current_user_Id = '';
   getUserInfo(){
    final db = _firestore.collection('Farmers').doc(FireAuth().currentUser!.uid);
    db.get().then(
      (DocumentSnapshot doc){
        if(doc.exists){
          final data = doc.data() as Map<String, dynamic>;

          setState(() {
            current_user_Name = data['username'];
            current_user_Id = data['id'];
            current_user_Name = data['username'];

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
 
 final _firestore = FirebaseFirestore.instance;
String uid = FireAuth().currentUser!.uid;


  @override
  Widget build(BuildContext context) {   
    int selectedIndex = 1;

     void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(9, 178, 77, 1),
                      Color.fromRGBO(150, 201, 61, 1)
                
                    ])
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                        child: Row(
                          children: [
                            Expanded(child: Text('Chat', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),)),
                            Icon(Icons.notifications),
                            Icon(Icons.more_vert)
                          ],
                        ),
                      ),
                    
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            prefixIconColor: kTextColor,
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Search chats',
                            hintStyle: TextStyle(color: kTextColor, fontSize: 14, fontWeight: FontWeight.w500),
                            filled: true,
                            fillColor: kColorSecondary,
                            enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide.none,
                          ),
                          )
                          ),
                      ),
                      
                    ],
                  ),
                ),
        
                StreamBuilder(
                  stream: _firestore.collection('Chatting/$uid/chatting').snapshots(),
                  builder: (context, snapshot){
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(color: kColorPrimary,),
                      );
                    }
                    int itemCount = snapshot.data!.docs.length;
                    return ListView.builder(
                
                shrinkWrap: true,
                itemCount: itemCount,
                itemBuilder: (context, index){
                  DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                  
                  
                    
        
                    String username = documentSnapshot['username'];
                    String message = documentSnapshot['message'];
                    String time = documentSnapshot['time'];
                    
                  
                  
                  return GestureDetector(
                    onTap: () {
                      String roomId = chatRoomId(current_user_Name, username);
        
                      Navigator.push(context, MaterialPageRoute(builder: ((context) {
                        return ChattingScreen( var1: username, var2: documentSnapshot['id'], var3: roomId);
                      })));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                      child: Container(
                        padding: EdgeInsets.only(top: 7.0, bottom: 7, right: 20.0, left: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, ),
                          boxShadow: [
                            BoxShadow(
                              color: kColorSecondary,
                              blurRadius: 2,
                              spreadRadius: .5,
                              blurStyle: BlurStyle.outer
                            ),
                            BoxShadow(
                              color: Color.fromARGB(26, 34, 33, 33),
                              blurRadius: 5,
                              spreadRadius: .5,
                              blurStyle: BlurStyle.outer
                            )
                          ],
                          
                          borderRadius: BorderRadius.circular(10)
                        ),
                            child: Row(
                              children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(''),
                        backgroundColor: Colors.white,
                        radius: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(username, style: TextStyle(fontWeight: FontWeight.w600, ),),
                              SizedBox(height: 5,),
                              Text(message,  style: TextStyle(overflow: TextOverflow.ellipsis))
                            ],
                          ),
                        ),
                      ),
                          
                      Text(time)
                              ],
                            ),
                          ),
                    ),
                  );
                }
                );
                  })
               
            
               
              ],
            ),
          ),
        ),
      ),

      
      floatingActionButton: FloatingActionButton(
        backgroundColor: kColorPrimary,
        isExtended: true,
        // the floating is to add and say 'join a forum and it leads you to search for furms to join.'
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return SearchUsers();
          })));
        },
        child: Icon(Icons.message_rounded, color: kColorSecondary,),
        hoverElevation: 4,
        
        ),


      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: _onItemTapped,
          unselectedItemColor:  kTextColor,
          selectedItemColor:  kColorPrimary,
          type: BottomNavigationBarType.fixed,
          // unselectedLabelStyle: TextStyle(
          //   color: Colors.black
          // ),
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600
          ),
          
          items: [
            BottomNavigationBarItem(
              icon: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return WelcomeScreen();
                })));},
                child: Icon(Icons.home_filled,)),
              label: 'Home', 
              ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return Chat();
                })));},
                child: Icon(Icons.chat_bubble_outline_rounded ,)),
              label: 'Chat'
              ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return Forums();
                })));},
                child: Icon(Icons.groups_2,)),
              label: 'Forums'
              ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                      return FarmersProfile();
                    }));
                },
                child: Icon(Icons.person_2_outlined,)),
              label: 'Profile'
              ),
          ]),
    );
      
  
  }

 
}