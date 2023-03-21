import 'package:farmers_connect/Farmer/login.dart';
import 'package:farmers_connect/REO/onboarding2.dart';
import 'package:farmers_connect/Farmer/sign_up_2.dart';
import 'package:farmers_connect/Farmer/sign_up_tab1.dart';
import 'package:farmers_connect/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70, bottom: 50),
              child: Column(
                children: [
                  const Text(
                    'FarmersConnect',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                   Text(
                    '...connecting farmers',
                    style: TextStyle(
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                        color: Color.fromRGBO(105, 105, 105, 1),
                        fontFamily: 'Poppins'
                        ),
                  ),
                ],
              ),
            ),
      
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 20.0),
               child: OutlinedButton(
                onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) {
                      return Farmers_SignUp2();
                    })));
                  
                },
                child: Text('Sign Up', 
                    style: TextStyle(
                      color: kColorPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat'
                  ),),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                      color: kColorPrimary,
                    ),
                  padding: EdgeInsetsDirectional.symmetric(vertical: 20)),
                         ),
             ),
      
            Text('Already have an account?', 
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(105, 105, 105, 1),
                 fontFamily: 'Montserrat'
              ),),
      
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                onPressed: 
                  (){
                    Navigator.push(context, MaterialPageRoute(builder: ((context) {
                      return FarmersLogin();
                    })));
                  },
                
                child: Text('Login', 
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                    color: Colors.white
                  ),),
                style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      color: kColorPrimary,
                    ),
                    padding: EdgeInsetsDirectional.symmetric(vertical: 20)),
              ),
            ),
      
            Text('Are you a Rural Extension Officer or an Agricultural Expert?',
                style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: kTextColor,
                 fontFamily: 'Montserrat'
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: ((context) {
                      return REO_Onborading();
                    })));
                  }, 
                  child: Text('Click here', 
                    style: TextStyle(color: kColorPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat'
                    ),)),
                Text('to register/login', 
                    style: TextStyle(color: Color.fromRGBO(105, 105, 105, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                     fontFamily: 'Montserrat'
                    ) 
                )
              ],
            ),
      
            
          ],
        ),
      ),
    );
  }
}
