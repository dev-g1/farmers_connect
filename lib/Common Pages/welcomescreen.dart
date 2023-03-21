import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_connect/Farmer/Chat/chat.dart';
import 'package:farmers_connect/Farmer/Forum/my_forums.dart';
import 'package:farmers_connect/Farmer/login.dart';
import 'package:farmers_connect/Farmer/onboarding.dart';
import 'package:farmers_connect/Firebase/fire_auth.dart';
import 'package:farmers_connect/Profiles/farmer_profile.dart';
import 'package:farmers_connect/Profiles/reo_profile.dart';
import 'package:farmers_connect/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}



class _WelcomeScreenState extends State<WelcomeScreen> {
   User? loggedInUser;
   String userName = '';
   String user = '';

  
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
          userName = data['username'];
          user = data['user?'];
        });
      }
      
      
    },
    onError: (e) => print(e)
    );
    
   print(userName);
   }

   
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
    setState(() {});
  }


  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Container(
           
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/cow-farm-animal-dairy 1.png')),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
              child: Container(
                 width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  // gradient: LinearGradient( begin: Alignment.bottomLeft, colors: [ kColorPrimary, Colors.grey.shade300, kColorSecondary, ] ),
                  color: Color.fromRGBO(221, 243, 221, 0.473),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: FarmersConnect_Logo(),
                    ),
                    Divider(color: kColorPrimary,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text('Welcome,'),
                              SizedBox(width: 7,),
                              Text(userName, style: kTextStyle1d, overflow: TextOverflow.ellipsis,)
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            FireAuth().signOut();
                            
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                return OnboardingScreen();
                              }));
                            
                          },
                          icon: Icon(Icons.logout_sharp), ),
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
              
                        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    if (user == 'Farmer') {
                      Navigator.push(context, MaterialPageRoute(builder: ((context) {
                      return FarmersProfile(); 
                      }))); 
                    } else if(user == 'REO') {
                       Navigator.push(context, MaterialPageRoute(builder: ((context) {
                      return REO_Profile(); 
                      }))); 
                    }
                  },
                  child: Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: EdgeInsets.symmetric(vertical: 50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.person,
                        color: kColorPrimary,
                      ),
                    ),
                  ),
                ),
                Text('Profile',),
              ],
            ),
          ),
            ), 
                      Cards(Icons.groups, 'Community', Forums())],
                    ),
                    Row(
                      //  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Cards(Icons.phone, 'Contact us', Chat() ),
                        Cards(Icons.chat_bubble_outline_sharp, 'Chat', Chat())
                        // Card(  
                        //   color: kColorSecondary,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(40.0),
                        //     child: Image.asset('assets/images/Vector.png'),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(20.0),
                        //   child: Column(
                        //     children: [
                        //       Container(
                        //         width: MediaQuery.of(context).size.width *0.15,
                        //         padding: EdgeInsets.all(40),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(20),
                        //           color: kColorSecondary,
                        //         ),
                        //         child: Image.asset('assets/images/Vector.png',),
                        //       ),
                        //       Text('Chat')
                        //     ],
                        //   ),
                        // )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Cards extends StatelessWidget {
  IconData icon;
  String title;
  Widget navTo;

  Cards(this.icon, this.title, this.navTo);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return navTo;
                })));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                padding: EdgeInsets.symmetric( vertical:50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Expanded(
                  child: Center(
                    child: Icon(
                      icon,
                      color: kColorPrimary,
                    ),
                  ),
                ),
              ),
            ),
            Text(title,),
          ],
        ),
      ),
    );
  }
}
