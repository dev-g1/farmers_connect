// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_connect/Farmer/Chat/chatting.dart';
import 'package:farmers_connect/Farmer/Forum/forumScreen.dart';
import 'package:farmers_connect/Firebase/fire_auth.dart';
import 'package:farmers_connect/constants.dart';
import 'package:flutter/material.dart';


class AboutForum extends StatefulWidget {
   AboutForum({super.key, required this.var1, required this.var2});
  String var1;
  String var2;

  @override
  State<AboutForum> createState() => _AboutForumState();
}


class _AboutForumState extends State<AboutForum> {
  final _firestore = FirebaseFirestore.instance;
  TextEditingController messageController = TextEditingController();
  bool subscribed = false;
  String userName = '';  

      getUserInfo() async {
   final docRef =  FirebaseFirestore.instance.collection('Farmers').doc(FireAuth().currentUser!.uid);
   await docRef.get().then(
    (DocumentSnapshot doc){
      if (doc.exists){
        final data = doc.data() as Map<String, dynamic>;
        // final String userName = data['f_name'];
        print(data);
        print(userName);

        setState(() {
          userName = data['f_name'];
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
   String forumName = widget.var1;
   String about = widget.var2;
   


  //   getUserInfo() async {
  //  final docRef =  FirebaseFirestore.instance.collection('Forums').doc(FireAuth().currentUser!.uid);
  //  await docRef.get().then(
  //   (DocumentSnapshot doc){
  //     if (doc.exists){
  //       final data = doc.data() as Map<String, dynamic>;
  //       // final String userName = data['f_name'];
  //       print(data);
  //       print(forumName);

  //       setState(() {
  //         about = data[forumName]['About'];
  //         // forumName = data['Title'];
  //       });
  //     }
  //   }
  //  );
  //  }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      // opacity: .7,
                      alignment: Alignment.topRight,
                      fit: BoxFit.contain,
                      repeat: ImageRepeat.repeatY,
                      image: AssetImage('assets/images/Food.png')),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                              )),
                          // IconButton(
                          //   onPressed: (){},
                          //   icon: Icon(Icons, color: Colors.white,)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            forumName,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 243, 240, 240),
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          
      
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              // gradient: ,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(219, 204, 190, 1),
                                Color.fromRGBO(255, 255, 255, 10)
                              ])),
      
                              child: 
                               Text(
                                    about,
                                    style: TextStyle(height: 1.7, fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                                  ),
                          // child: ListView(
                          //   physics: BouncingScrollPhysics(),
                          //   children: [
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Padding(
                          //           padding:
                          //               const EdgeInsets.symmetric(vertical: 8),
                          //           child: Container(
                          //             padding: EdgeInsets.symmetric(
                          //                 vertical: 10, horizontal: 10),
                          //             decoration: BoxDecoration(
                          //                 color: Colors.white,
                          //                 border: Border.all(
                          //                   color: kColorPrimary,
                          //                 ),
                          //                 borderRadius: BorderRadius.all(
                          //                     Radius.circular(10))),
                          //             child: Row(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.start,
                          //               children: [
                          //                 CircleAvatar(
                          //                   backgroundImage: AssetImage(
                          //                       'assets/images/Food.png'),
                          //                   radius: 20,
                          //                 ),
                          //                 SizedBox(
                          //                   width: 10,
                          //                 ),
                          //                 Column(
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   children: [
                          //                     Text(
                          //                       '',
                          //                       style: kTextStyle1d,
                          //                     ),
                          //                     SizedBox(
                          //                       height: 5,
                          //                     ),
                          //                     Text(''),
                          //                     SizedBox(
                          //                       height: 7,
                          //                     ),
                          //                     Text(''),
                          //                   ],
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         StreamBuilder(
                          //             stream: _firestore.collection('/Forums/$forumName/messages').snapshots(),
                          //             builder: ((context, snapshot) {
                          //               if (!snapshot.hasData) {
                          //                 return Center(
                          //                   child: CircularProgressIndicator(
                          //                     color: kColorPrimary,
                          //                   ),
                          //                 );
                          //               }
                          //               int itemCount = snapshot.data!.docs.length;
                          //               return ListView.builder(
                          //                   shrinkWrap: true,
                          //                   reverse: true,
                          //                   physics: ScrollPhysics(),
                          //                   itemCount: snapshot.data?.docs.length,
                          //                   itemBuilder: (context, index) {
                          //                     DocumentSnapshot documentSnapshot =snapshot.data!.docs[index];
                          //                     return Padding(
                          //                       padding:
                          //                           const EdgeInsets.symmetric(
                          //                               vertical: 8),
                          //                       child: Expanded(
                          //                         child: Container(
                          //                           padding: EdgeInsets.symmetric(
                          //                               vertical: 10,
                          //                               horizontal: 10),
                          //                           decoration: BoxDecoration(
                          //                               color: Colors.white,
                          //                               border: Border.all(
                          //                                 color: kColorPrimary,
                          //                               ),
                          //                               borderRadius:
                          //                                   BorderRadius.all(
                          //                                       Radius.circular(
                          //                                           10))),
                          //                           child: Row(
                          //                             crossAxisAlignment:
                          //                                 CrossAxisAlignment.start,
                          //                             children: [
                          //                               CircleAvatar(
                          //                                 backgroundImage: AssetImage(
                          //                                     'assets/images/Food.png'),
                          //                                 radius: 20,
                          //                               ),
                          //                               SizedBox(
                          //                                 width: 10,
                          //                               ),
                          //                               Column(
                          //                                 crossAxisAlignment:
                          //                                     CrossAxisAlignment
                          //                                         .start,
                          //                                 children: [
                          //                                   Text(
                          //                                     documentSnapshot[ 'userName'] ?? '',
                          //                                     style: kTextStyle1d,
                          //                                   ),
                          //                                   SizedBox(
                          //                                     height: 5,
                          //                                   ),
                          //                                   Text(documentSnapshot['time'] ??''),
                          //                                   SizedBox(
                          //                                     height: 7,
                          //                                   ),
                          //                                   Expanded(child: RichText(text: TextSpan(text: '${documentSnapshot['message'] }')))
                          //                                 ],
                          //                               ),
                          //                             ],
                          //                           ),
                          //                         ),
                          //                       ),
                          //                     );
                          //                   });
                          //             })),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
      
            Container(
              width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: kColorPrimary,
                    borderRadius: BorderRadius.circular(.5)),
                padding: EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ForumScreen(var1: forumName, var2: about);
                  }));
      
                    final message = <String, dynamic>{
                  'Title': forumName,
                  'About' : about,
                  'member' : true
                };
                _firestore.collection('MyForums/${FireAuth().currentUser!.uid}/myForums').add(message);
      
                  },
                  child: Text( 'Join' ,
                    style: TextStyle(color: Colors.white),
                  ),
                )),
      
            // Visibility( 
            //   visible: (subscribed == false) ? false : true,
            //   child: SendMessage(() {
            //     final message = <String, dynamic>{
            //       'message': messageController.text,
            //       'userName' : userName,
            //       'time': TimeOfDay.fromDateTime(DateTime.now()).toString()
            //     };
            //     _firestore.collection('/Forums/$forumName/messages').add(message);
            
            //     messageController.text = '';
            //   }, messageController),
            // )
          ],
        ),
      ),
    );
  }
}

class ForumPosts extends StatelessWidget {
  const ForumPosts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: kColorPrimary,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/Food.png'),
              radius: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '',
                  style: kTextStyle1d,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(''),
                SizedBox(
                  height: 7,
                ),
                Text('')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
