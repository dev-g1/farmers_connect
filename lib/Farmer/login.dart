// ignore_for_file: prefer_const_constructors

import 'package:farmers_connect/Common%20Pages/welcomescreen.dart';
import 'package:farmers_connect/Farmer/onboarding.dart';
import 'package:farmers_connect/Farmer/sign_up_tab1.dart';
import 'package:farmers_connect/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class FarmersLogin extends StatefulWidget {
  const FarmersLogin({super.key});

  @override
  State<FarmersLogin> createState() => _FarmersLoginState();
}

class _FarmersLoginState extends State<FarmersLogin> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
    bool isLoading = false;

    final _firebase = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                    
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 50.0),
                        child: FarmersConnect_Logo(),
                      )
                    ],
                  ),
                    
                  Align(
                    alignment: Alignment.center,
                    child: Text('Welcome Back!', style: TextStyle(fontWeight: FontWeight.w600),)),
                  SizedBox(height: 25,),
                  const Text(
                    'Email address',
                    style: kTextStyle1,
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextField(
                      controller: phoneNumberController,
                      decoration: kTextFieldDecoration,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Password',
                    style: kTextStyle1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: kTextFieldDecoration2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final snackbar1 = SnackBar(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          content: Text('Logged In Successfully', 
                          style: TextStyle(color: kColorPrimary,  fontSize: 16),),
                          backgroundColor: kColorSecondary,
                          duration: Duration(seconds: 5),
                          );
                        
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          final user = await _firebase.signInWithEmailAndPassword(email: 
                          phoneNumberController.text, password: passwordController.text);
                          
                          if (user != null) {
                            Navigator.push(context, MaterialPageRoute(builder: ((context) {
                                return WelcomeScreen();
                              })));
                              
                            print(user);
                            ScaffoldMessenger.of(context).showSnackBar(snackbar1);
                            
                          }
                          
                          
                        } on FirebaseAuthException catch (e) {
                          print(e.message);
                  
                          final snackbar2 = SnackBar(
                          content: Text('${e.message}', 
                          style: TextStyle(color: kColorPrimary, fontSize: 16)),
                          backgroundColor: kColorSecondary,
                          duration: Duration(seconds: 5),
                          );
                  
                          setState(() {
                          isLoading  = false;
                        });
                  
                           ScaffoldMessenger.of(context).showSnackBar(snackbar2);
                        };
                  
                        
                        
                      },
                      child: Text('Login', 
                         style: TextStyle(
                            color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Montserrat'
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsetsDirectional.symmetric(vertical: 20)),
                    ),
                  ),
        
                  RichText(text: TextSpan(
                   // ignore: prefer_const_literals_to_create_immutables
                   children: [
                    TextSpan(
                      text: 'Don\'t have an account?',
                      style: TextStyle(
                              color: kTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Montserrat'
                          ),
                    ),
                   
                    TextSpan(
                      text: ' Click here ',
                      style: TextStyle(
                              color: kColorPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Montserrat'
                          ),
                      recognizer: TapGestureRecognizer()..onTap =() {
                        Navigator.push(context, MaterialPageRoute(builder: ((context) {
                              return OnboardingScreen();
                            })));
                      },
                    ),
                  
                    TextSpan(
                      text: 'to register',
                      style: TextStyle(
                              color: kTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Montserrat'
                          ),
                    ),
                  
                  
                   ]
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FarmersConnect_Logo extends StatelessWidget {
  const FarmersConnect_Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'FarmersConnect',
          style: kLogoTextStyle1
        ),
        Text(
          '...connecting farmers',
          style: kLogoTextStyle2
        ),
      ],
    );
  }
}
