import 'package:farmers_connect/Farmer/login.dart';
import 'package:farmers_connect/Farmer/onboarding.dart';
import 'package:farmers_connect/Onboarding%20Screens/intro_screen1.dart';
import 'package:farmers_connect/Onboarding%20Screens/intro_screen2.dart';
import 'package:farmers_connect/Onboarding%20Screens/intro_screen3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});

  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {
  PageController _pageController = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index){
                  setState(() {
                    onLastPage = (index == 2);
                  });
              },
              children: [
                Intro_Screen1(),
                Intro_Screen2(),
                Intro_Screen3(),
              ],

              )
          ),
          Container(
                  alignment: Alignment(0, 0.95),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                       GestureDetector(
                        onTap: (){
                          _pageController.jumpToPage(2);
                        },
                        child: Text('Skip', 
                        style: TextStyle(
                          color: Colors.white, 
                          fontWeight: FontWeight.w400),)),

                      SmoothPageIndicator(
                        controller: _pageController, 
                        count: 3,
                        effect: SlideEffect(
                          radius: 2,
                          dotColor: Colors.white,
                          activeDotColor: Color(0xFFf19a05)
                        ),
                        ),
                      
                      onLastPage ?
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: ((context) {
                            return OnboardingScreen();
                          })));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric( horizontal: 12,vertical: 7),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text('Sign up',
                            style: TextStyle(
                            color: Color(0xFF03341c), 
                            fontWeight: FontWeight.w700,
                             ),
                            
                          ),
                        ))

                      :  GestureDetector(
                        onTap: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 600), 
                            curve: Curves.bounceInOut);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric( horizontal: 12,vertical: 7),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade800,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text('Next',
                            style: TextStyle(
                            color: Colors.white, 
                            fontWeight: FontWeight.w400,
                             ),
                            
                          ),
                        ))
                    ],
                  ),
                )
        ],
      )
    );
  }
}