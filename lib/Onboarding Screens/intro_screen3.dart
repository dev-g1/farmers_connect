import 'package:farmers_connect/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Intro_Screen3 extends StatefulWidget {
  const Intro_Screen3 ({super.key});

  @override
  State<Intro_Screen3> createState() => _Intro_Screen1State();
}

class _Intro_Screen1State extends State<Intro_Screen3 > {

  final Color kSplashScreenColor = Color(0xFF03341c);

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorSecondary,
        body: SafeArea(
          child: Expanded(
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
                      padding: const EdgeInsets.all(20.0),
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
                          child: Image.asset('assets/images/farmer4.jpg', 
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
                      padding: EdgeInsets.all(20),
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
                          Text('   Quality Information & Tips ', 
                          style: TextStyle(
                            color: Color(0xFFf19a05), 
                            fontSize: 20, 
                            fontWeight: FontWeight.w600),),
                            SizedBox(
                              height: 10,
                            ),
                            RichText(text: TextSpan(
                              children: [
                                  TextSpan(
                                    text: '- Get firsthand information on latest farming methods, practices and technologies. ',
          
                                    style: TextStyle(
                                    color: Colors.white, 
                                    fontSize: 16, 
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins',
                                    height: 2,
                                    wordSpacing: 2,
                                    )
                                  ),
                                  TextSpan(
                                    text: '\n- Get tips on how to optimize crop yields, improve farm production and solve common farming problems. ',
          
                                    style: TextStyle(
                                    color: Colors.white, 
                                    fontSize: 16, 
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins',
                                    height: 2,
                                    wordSpacing: 2,
                                    )
                                  ),
                                  
                              ]
                            )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}