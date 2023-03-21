import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_connect/Farmer/sign_up_tab1.dart';
import 'package:farmers_connect/Firebase/fire_auth.dart';
import 'package:farmers_connect/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Farmers_SignUp2 extends StatefulWidget {
  @override
  State<Farmers_SignUp2> createState() => _Farmers_SignUp2State();
}

class _Farmers_SignUp2State extends State<Farmers_SignUp2> {
  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController re_enterController = TextEditingController();

  final _firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Expanded(
              child: SingleChildScrollView(
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
                    // Container(
                    //   child: Text(
                    //     'Create Account',
                    //     style: TextStyle(
                    //       color: kColorPrimary,
                    //     ),
                    //   ),
                    // ),
                    const Text(
                      'Email address',
                      style: kTextStyle1d,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextField(
                        controller: phoneNumberController,
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
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: phoneNumberController.text, password: passwordController.text); 
                          
                             if (user != null){
                            Navigator.push(context, MaterialPageRoute(builder: ((context) {
                              return FarmerSignUp_01();
                            })));
                          }
                          }on FirebaseAuthException catch (e) {
                            print(e.message);
                          
                            final snackbar2 = SnackBar(
                            content: Text('${e.message}', 
                            style: TextStyle(color: kColorPrimary, fontSize: 16)),
                            backgroundColor: kColorSecondary,
                            duration: Duration(seconds: 5),
                            );
                          
                          setState(() {
                            isLoading = false;
                          });
                          
                          ScaffoldMessenger.of(context).showSnackBar(snackbar2);
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
                            padding: EdgeInsetsDirectional.symmetric(vertical: 20, ),),
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
