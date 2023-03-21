import 'package:farmers_connect/REO/Sign-up/signup.dart';
import 'package:farmers_connect/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class REO_Sign_Up3 extends StatefulWidget {
  @override
  State<REO_Sign_Up3> createState() => _REO_Sign_Up3State();
}

class _REO_Sign_Up3State extends State<REO_Sign_Up3> {
  final _firebase = FirebaseAuth.instance;

  final _firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController re_enterController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Container(
                        height: 50,
                        child: Text(
                          'Create account',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        decoration: BoxDecoration(color: kColorPrimary),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      ),
                    ),
                    
                    const Text(
                      'Email address',
                      style: kTextStyle1d,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: kTextFieldDecoration,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Password',
                      style: kTextStyle1d,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextField(
                        obscureText: true,
                        // keyboardType: TextInputType.phone,
                        controller: passwordController,
                        decoration: kTextFieldDecoration2,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Re-enter Password',
                      style: kTextStyle1d,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextField(
                        obscureText: true,
                        // keyboardType: TextInputType.phone,
                        controller: re_enterController,
                        decoration: kTextFieldDecoration2,
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     // Checkbox(
                    //     //   value: false,
                    //     //   checkColor: kColorPrimary,
                    //     //   focusColor: kColorPrimary,
                    //     //   onChanged: ((value) {
                    //     //     setState(() {
                    //     //       value = true;
                    //     //     });
                    //     //   })),
                    //     // Text('Remember me'),
                    //     TextButton(
                    //         onPressed: () {},
                    //         child: Text(
                    //           'Forgot Password?',
                    //           style: TextStyle(
                    //               color: kColorPrimary,
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w500,
                    //               fontFamily: 'Montserrat'),
                    //         ))
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 80),
                      child: ElevatedButton(
                        onPressed: () async {
                          // final snackbar1 = SnackBar(
                          //   padding: EdgeInsets.symmetric(vertical: 20),
                          //   content: Text('Account Created Successfully', 
                          //   style: TextStyle(color: kColorPrimary,  fontSize: 16),),
                          //   backgroundColor: kColorSecondary,
                          //   duration: Duration(seconds: 5),
                          //   );
                          
                          setState(() {
                            isLoading = true;
                          });
                
                          if (passwordController.text != null &&
                              passwordController.text == re_enterController.text) {
                            try {
                              final user =
                                  await _firebase.createUserWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: passwordController.text);
                              if (user != null) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: ((context) {
                                  return REO_Sign_Up1();
                                })));
                
                                print(user);
                              // ScaffoldMessenger.of(context).showSnackBar(snackbar1);
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
                            }
                          }
                        },
                        child: Text(
                          'Create account',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Montserrat'),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsetsDirectional.symmetric(
                            vertical: 20,
                          ),
                        ),
                      ),
                    ),
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
