import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_connect/Farmer/sign_up_tab1.dart';
import 'package:farmers_connect/Firebase/fire_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:farmers_connect/Common%20Pages/welcomescreen.dart';
import 'package:farmers_connect/Farmer/Chat/chat.dart';
import 'package:farmers_connect/Farmer/Forum/my_forums.dart';
import 'package:farmers_connect/constants.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class FarmersProfile extends StatefulWidget {
  const FarmersProfile({super.key});

  @override
  State<FarmersProfile> createState() => _FarmersProfileState();
}

class _FarmersProfileState extends State<FarmersProfile> {

  final _firestore = FirebaseFirestore.instance;
  int selectedIndex = 3;

  void _onItemTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  String user_Name = '';
  String state = '';
  String farming_type = '';
  String farming_scale = '';
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
            farming_type = data['farming_type'];
            farming_scale = data['farming_scale'];
            imageUrl = data['img_Url'];
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
        await ref.putFile(_photo!);

        final String imgUrl = await ref.getDownloadURL();


        await _firestore.collection('Farmers').doc(FireAuth().currentUser!.uid).set({
          'img_Url' : imgUrl
        }, 
        
        SetOptions(merge: true));
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF026706),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 40, 20, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // RichText(text: TextSpan( text: 'Famers'), )
                  Column(
                    children: [
                      RichText(text: 
            TextSpan(
              children: [
                TextSpan(
                      text:'Farmers',
                      style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600, ),
                ),
                TextSpan(
                      text: 'Connect', 
                      style: TextStyle(fontFamily: 'Poppins', color: Color(0xFFf19a05), fontSize: 24, fontWeight: FontWeight.w600, ),
                )
            
              ]
            )
            ),
                Text('. . . connecting farmers',
                style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),
                ),
                    ],
                  ),
                  // Text('FarmersConnect',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 20, 
                  //     fontFamily: 'Poppins',
                  //     fontWeight: FontWeight.w600,
                  //     letterSpacing: 2 
                  //   ),
                  // ),
                  PopupMenuButton(
                    onSelected: (value) {
                      Navigator.push(context, MaterialPageRoute(builder: ((context) {
                        return FarmerSignUp_01();
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
        
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(imageUrl),
                      
                      
                      ),
                      
                      Positioned(
                        left: 65,
                        top: 60,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                          color: kColorPrimary,
                          borderRadius: BorderRadius.circular(40)
                          ),
                          child: Icon(Icons.camera_alt, color: kColorSecondary, )),
                      )
                    ],
                  ),
                ),
              ),
        
              Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    Profile('Name', user_Name, 40),
                    SizedBox(height: 30,),
                    Profile('State', state, 45),
                    SizedBox(height: 30,),
                    Profile('Scale', ' $farming_scale scale farmer', 45),
                    SizedBox(height: 30,),
                    Profile('Type', ' $farming_type farming', 50),
                    SizedBox(height: 30,),
                    // Profile('Forums', 'Irrigation', 25),
                    
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
                        return FarmersProfile();
                      }));
                    },
                    child: Icon(Icons.person_2_outlined,)),
                  label: 'Profile'
                  ),
              ]),
        ),
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