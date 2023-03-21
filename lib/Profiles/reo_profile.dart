import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_connect/Firebase/fire_auth.dart';
import 'package:farmers_connect/REO/Sign-up/signup.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:farmers_connect/Common%20Pages/welcomescreen.dart';
import 'package:farmers_connect/Farmer/Chat/chat.dart';
import 'package:farmers_connect/Farmer/Forum/my_forums.dart';
import 'package:farmers_connect/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class REO_Profile extends StatefulWidget {
  const REO_Profile({super.key});

  @override
  State<REO_Profile> createState() => _REO_ProfileState();
}

class _REO_ProfileState extends State<REO_Profile> {

  final _firestore = FirebaseFirestore.instance;
  int selectedIndex = 3;

  void _onItemTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  String user_Name = '';
  String state = '';
  String region = '';
  String expertise = '';
  String experience = '';
  String imageUrl = '';
  

  getUserInfo(){
    final db = _firestore.collection('Farmers').doc(FireAuth().currentUser!.uid);
    db.get().then(
      (DocumentSnapshot doc){
        if(doc.exists){
          final data = doc.data() as Map<String, dynamic>;

          setState(() {
            user_Name = data['username'];
            state = data['state'];
            region = data['region'];
            expertise = data['expertise'];
            experience = data['expertise'];
            imageUrl = data['img_url'];
            
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

  final _fireStorage = FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future<void> _upload() async {
    // XFile? pickedImage;
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {   
        final ref = _fireStorage.ref(destination).child('file/');
        final uploadImg = await ref.putFile(_photo!);

        final img_url = uploadImg.ref.getDownloadURL();

        await _firestore.collection('REO').doc(FireAuth().currentUser!.uid).set({
          'img_url' : img_url
        }, 
        SetOptions(merge: true)
        );


    } catch (e) {
        print(e);
    }
  }

  Future<void> imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        _upload();
      } else {
        print('No image found');
      }
    });
  }

  Future<void> imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        _upload();
      } else {
        print('No image found');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF026706),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 40, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // RichText(text: TextSpan( text: 'Famers'), )
                Text('FarmersConnect',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20, 
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2 
                  ),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) {
                      return REO_Sign_Up1();
                    })));
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text('Edit Profile'))
                  ],
                  child: Icon(Icons.more_vert, color: Colors.white,),
                  )
              ],
            ),
      
            GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(imageUrl),
                    backgroundColor: kColorSecondary
                    // child: _photo != null ? ClipRRect(
                    //   borderRadius: BorderRadius.circular(50),
                    //   child: Image.file(
                    //     _photo!,
                    //     width: 100,
                    //     height: 100,
                    //     fit: BoxFit.fitHeight,
                    //   ),
                    // ) :
                    // Container(
                    //   decoration : BoxDecoration(
                    //     color: kTextColor2,
                    //     borderRadius: BorderRadius.circular(50),
                    //   ),
                    //   width: 100,
                    //   height: 100,
                    //   child: Icon(
                    //     Icons.camera_alt,
                    //     color: kColorSecondary,
                    //   ),
                    // )
                    // )
                  ),

                    Positioned(
                      left: 65,
                      top: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          color: kColorPrimary,
                           borderRadius: BorderRadius.circular(40)
                        ),
                        child: Icon(Icons.camera_alt, color: kColorSecondary, ))),
                ],
              ),
            ),
      

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Profile2('Name'),
                      SizedBox(height: 30,),
                      Profile2('State'),
                       SizedBox(height: 30,),
                      Profile2('Region'),
                       SizedBox(height: 30,),
                      Profile2('Expertise'),
                       SizedBox(height: 30,),
                      Profile2('Experience'),
                    ],
                  ),
                  SizedBox(width: 30,),
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileValue(user_Name),
                       SizedBox(height: 30,),
                      ProfileValue(state),
                       SizedBox(height: 30,),
                      ProfileValue(region),
                       SizedBox(height: 30,),
                      ProfileValue(expertise),
                       SizedBox(height: 30,),
                      ProfileValue(experience),
                    ],
                  )
                ],
              ),
            )
          
          ],
        ),
      ),
      
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        child: BottomNavigationBar(
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
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return REO_Profile();
                    }));
                  },
                  child: Icon(Icons.person_2_outlined,)),
                label: 'Profile'
                ),
            ]),
      ),
    );
  }

  void _showPicker(context){
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
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: (){
                  imgFromCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ) 
        
        );
      });
  }
}

class ProfileValue extends StatelessWidget {
   ProfileValue( this.textValue,);
  String textValue;

  // final String user_Name;

  @override
  Widget build(BuildContext context) {
    return Text(textValue, style: TextStyle(color: Colors.white, fontSize: 18 ));
  }
}

class Profile2 extends StatelessWidget {
   String title;
   Profile2(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(title , style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),);
  }
}


class Profile extends StatelessWidget {
   Profile(this.profile, this.feed, this.space);

  String profile;
  double space;
  String feed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text( profile, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),),
        SizedBox(width: space),
        Text(feed, style: TextStyle(color: Colors.white, fontSize: 18 )),

      ],
    );
  }
}