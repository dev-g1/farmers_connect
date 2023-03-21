// ignore_for_file: prefer_const_constructors

import 'package:farmers_connect/Farmer/login.dart';
import 'package:farmers_connect/REO/Sign-up/signup.dart';
import 'package:farmers_connect/REO/Sign-up/signup3.dart';
import 'package:farmers_connect/constants.dart';
import 'package:flutter/material.dart';


class REO_Onborading extends StatelessWidget {
  const REO_Onborading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: kColorPrimary,
                    boxShadow: kShadow
                    ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Column(
                      children: [
                        const Text(
                          'FarmersConnect',
                          style: kLogoTextStyle1b
                        ),
                        Text(
                          '...connecting farmers',
                          style: kLogoTextStyle2b
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Rural Extension Officers/Agricultural Experts',
                     style: TextStyle(fontFamily: 'Montserrat', fontSize: 20, fontWeight: FontWeight.w600)
                  ),
                ),
                Container(
                  // width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: kShadow
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        'What is the role of the extension officer?',
                        style: TextStyle(fontFamily: 'Montserrat', fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Text(
                          '''Agricultural extension officers are intermediaries between research and farmers. They operate as facilitators and communicators, helping farmers in their decision-making and ensuring that appropriate knowledge is implemented to obtain the best results with regard to sustainable production and general rural development.''',style: kTextStyle2, ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text('What is the role of extension?',  style: TextStyle(fontFamily: 'Montserrat', fontSize: 18, fontWeight: FontWeight.w600),),
                      ),
                      Text(
                        '''- Extension is an informal educational process directed toward the rural population. This process offers advice and information to help them solve their problems. Extension also aims to increase the efficiency of the family farm, increase production and generally increase the standard of living of the farm family.''', style: kTextStyle2,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: ((context) {
                        return REO_Sign_Up3();
                      })));
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: kColorPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Montserrat'),
                    ),
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: kColorPrimary,
                        ),
                        padding: EdgeInsetsDirectional.symmetric(vertical: 20)),
                  ),
                ),
                Text(
                  'Already have an account?',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: kTextColor,
                      fontFamily: 'Montserrat'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: ((context) {
                        return FarmersLogin();
                      })));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Montserrat',
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          color: kColorPrimary,
                        ),
                        padding: EdgeInsetsDirectional.symmetric(vertical: 20)),
                  ),
                ),
              ],
            ),
          ),
        ]
        ),
      );
  }
}
