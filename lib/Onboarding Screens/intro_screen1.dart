import 'package:farmers_connect/Onboarding%20Screens/intro_screen2.dart';
import 'package:farmers_connect/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Intro_Screen1 extends StatefulWidget {
  const Intro_Screen1 ({super.key});

  @override
  State<Intro_Screen1> createState() => _Intro_Screen1State();
}

class _Intro_Screen1State extends State<Intro_Screen1 > {

  final Color kSplashScreenColor = Color(0xFF03341c);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorSecondary,
        body: SafeArea(
          child: Container(
            color: kColorSecondary,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    // color: kColorSecondary,
                    
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all( 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                       boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 0.5,
                          spreadRadius: 3,
                        )
                       ]
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/images/farmer6.jpg', 
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.5,
                        fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                    
                ),
          
               
          
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(25),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: kSplashScreenColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20), 
                        topRight: Radius.circular(20)),
                       boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 0.5,
                          spreadRadius: 3,
                        )
                       ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('  Community', 
                        style: TextStyle(
                          color: Color(0xFFf19a05), 
                          fontSize: 24, 
                          fontWeight: FontWeight.w600),),
                          SizedBox(
                            height: 20,
                          ),
                          RichText(text: TextSpan(
                            children: [
                                TextSpan(
                                  text: ' - Connect with other farmers around the country',
                                  style: TextStyle(
                                  color: Colors.white, 
                                  fontSize: 16, 
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins'
                                  )
                                ),
                                
                                TextSpan(
                                  text: '\n \n - Ask questions and get answers from other farmers. ',
                                  style: TextStyle(
                                  color: Colors.white, 
                                  fontSize: 16, 
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins'
                                  )
                                ),
                            ]
                          )),
                      ],
                    ),
                  ),
                ),

               
              ],
            ),
          ),
        ),
    );
  }
}