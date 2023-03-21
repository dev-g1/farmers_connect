import 'package:farmers_connect/Profiles/farmer_profile.dart';
import 'package:farmers_connect/Common%20Pages/welcomescreen.dart';
import 'package:farmers_connect/Farmer/Chat/chat.dart';
import 'package:farmers_connect/Farmer/Forum/my_forums.dart';
import 'package:farmers_connect/Farmer/login.dart';
import 'package:farmers_connect/Farmer/onboarding.dart';
import 'package:farmers_connect/REO/onboarding2.dart';
import 'package:farmers_connect/Farmer/sign_up_2.dart';
import 'package:farmers_connect/Farmer/sign_up_tab1.dart';
import 'package:farmers_connect/Firebase/fire_auth.dart';
import 'package:farmers_connect/REO/Sign-up/signup.dart';
import 'package:farmers_connect/REO/Sign-up/signup2.dart';
import 'package:farmers_connect/REO/Sign-up/signup3.dart';
import 'package:farmers_connect/firebase_options.dart';
import 'package:farmers_connect/models/forumsModel.dart';
import 'package:farmers_connect/splashscreen.dart';
import 'package:farmers_connect/utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:zego_zim/zego_zim.dart';
// import 'package:zego_zimkit/zego_zimkit.dart';
import 'package:intl/date_symbol_data_local.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized() ;
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  
  
  
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.green,
        primaryColorLight: Colors.green.shade900,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(2, 103, 6, 1.0))
        ),
      home: SplashScreen(),
      // home: FarmersProfile(),
    );
  }
}
