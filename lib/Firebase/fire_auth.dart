import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_connect/Common%20Pages/welcomescreen.dart';
import 'package:farmers_connect/Farmer/login.dart';
import 'package:farmers_connect/Farmer/onboarding.dart';
import 'package:farmers_connect/Onboarding%20Screens/onboardingscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireAuth {

  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore =  FirebaseFirestore.instance;
  Future createUserWithEmailAndPassword(String email, String password)async{
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

   
  }

  Future signInUserWithEmailandPassword(String email, String password)async{
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    // return 'Signed In';
  }

  Future<void> signOut ()async{
   await  _firebaseAuth.signOut();
  }

  User? get currentUser =>  _firebaseAuth.currentUser;

  Stream<User?> get authState => _firebaseAuth.authStateChanges();

String? getUserId(){
  return currentUser!.uid;
} 

isLoggedIn() async{
    if (currentUser != null) {
      return true;
    }else{
      return false;
    }
}
}

class Auth_User extends StatefulWidget {
  const Auth_User({super.key});

  @override
  State<Auth_User> createState() => _Auth_UserState();
}

class _Auth_UserState extends State<Auth_User> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder (
      stream: FireAuth().authState,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return WelcomeScreen();
        } else {
          return OnboardingScreen1();
        }
      },
    );
  }
}