import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_connect/Common%20Pages/welcomescreen.dart';
import 'package:farmers_connect/Farmer/Chat/chat.dart';
import 'package:farmers_connect/Farmer/Forum/create_new_forum.dart';
import 'package:farmers_connect/Farmer/Forum/find_forums.dart';
import 'package:farmers_connect/Farmer/Forum/aboutforum.dart';
import 'package:farmers_connect/Farmer/Forum/forumScreen.dart';
import 'package:farmers_connect/Firebase/fire_auth.dart';
import 'package:farmers_connect/Profiles/farmer_profile.dart';
import 'package:farmers_connect/constants.dart';
import 'package:flutter/material.dart';


class Forums extends StatefulWidget {
  const Forums({super.key});

  @override
  State<Forums> createState() => _ForumsState();
}

class _ForumsState extends State<Forums> {

  final _firestore = FirebaseFirestore.instance;
  int selectedIndex = 2;

  void _onItemTapped(int index){
    
    setState(() {
      selectedIndex = index;
    });
  }

  String forumName = '';
  getForumInfo(){
    final db = _firestore.collection('MyForums').doc(FireAuth().currentUser!.uid);
    db.get().then(
      (DocumentSnapshot doc){
        if(doc.exists){
          final data = doc.data() as Map<String, dynamic>;

          setState(() {
            forumName = data['Title'];
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/Rectangle 23.png'))
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.notifications, color: Colors.white,),
                          Icon(Icons.more_vert, color: Colors.white,)
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
                          hintText: 'Search forum',
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
            stream: _firestore.collection('MyForums/${FireAuth().currentUser!.uid}/myForums').snapshots(),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(color: kColorPrimary,),
              );
              }
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: ((context, index) {
                    DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 7),
                        child: GestureDetector(
                           onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context){
                                      return ForumScreen(var1: documentSnapshot['Title'] , var2: documentSnapshot['About'] );
                                    }));
                                },
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
                              color: Color.fromARGB(26, 105, 105, 105),
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
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                  ),
                                          
                                  SizedBox(width: 10,),
                                          
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(documentSnapshot['Title'] , style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                                        // SizedBox(height: 5,),
                                        // documentSnapshot['type'] == 'text' ? 
                                        // Text(documentSnapshot['message'] ?? '', softWrap: false,maxLines: 1, overflow: TextOverflow.ellipsis,)
                                        // : Row(
                                        //   children: [
                                        //     Icon(Icons.photo),
                                        //     SizedBox(width: 3,),
                                        //     Text('Photo')
                                        //   ],
                                        // )
                                      ],
                                    ),
                                  )
                                ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }));
            })),
            ]
          )
        ),
      ),
        
      floatingActionButton: FloatingActionButton(
        backgroundColor: kColorPrimary,
        isExtended: true,
        // the floating is to add and say 'join a forum and it leads you to search for furms to join.'
        onPressed: (){
          
        },
        child: PopupMenuButton<int>(
            onSelected: (value) {
              if (value == 1) {
                 Navigator.push(context, MaterialPageRoute(builder: ((context) {
                    return NewForum();
                  })));
              } else if(value == 2) {
                 Navigator.push(context, MaterialPageRoute(builder: ((context) {
                    return FindForums();
                  })));
              }
            },
            offset: Offset(0, -100),
            itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text('Create a new group')),
                PopupMenuItem(
                  value: 2,
                  child: Text('Find Forums'))
            ],
            
         icon: Icon(Icons.add),
            ),
          
        
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
                      return FarmersProfile() ;
                    }));
                },
                child: Icon(Icons.person_2_outlined,)),
              label: 'Profile'
              ),
          ]),
    );
      
  
  }
}
   