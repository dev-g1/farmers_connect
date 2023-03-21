import 'dart:async';

import 'package:farmers_connect/Farmer/onboarding.dart';
import 'package:farmers_connect/Firebase/fire_auth.dart';
import 'package:farmers_connect/Onboarding%20Screens/onboardingscreen.dart';
import 'package:farmers_connect/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
 
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Auth_User())));
  }
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF03341c),
      body: FarmersConnect_logo2()
    );
    
  }
}

class FarmersConnect_logo2 extends StatelessWidget {
  const FarmersConnect_logo2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(text: 
          TextSpan(
            children: [
              TextSpan(
                text:'Farmers',
                style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 34, fontWeight: FontWeight.w600, letterSpacing: 3),
              ),
              TextSpan(
                text: 'Connect', 
                style: TextStyle(fontFamily: 'Poppins', color: Color(0xFFf19a05), fontSize: 34, fontWeight: FontWeight.w600, letterSpacing: 3),
              )
          
            ]
          )
          ),
              Text('. . . connecting farmers',
              style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),
              )
        ],
      ),
    );
  }
}