import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_connect/Common%20Pages/welcomescreen.dart';
import 'package:farmers_connect/Firebase/fire_auth.dart';
import 'package:farmers_connect/Profiles/reo_profile.dart';
import 'package:farmers_connect/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class REO_Sign_Up2 extends StatefulWidget {
  const REO_Sign_Up2({super.key});

  @override
  State<REO_Sign_Up2> createState() => _REO_Sign_Up2State();
}

class _REO_Sign_Up2State extends State<REO_Sign_Up2> {
  bool isChecked = false;
  bool isLoading = false;

  final _firestore = FirebaseFirestore.instance;

  TextEditingController _reason_4_JoiningController = TextEditingController();
  TextEditingController _how_u_HelpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: ModalProgressHUD(
              inAsyncCall: isLoading,
              child: Padding(
                padding: const EdgeInsets.symmetric( vertical: 45.0, horizontal: 25.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Why do want to join?', style: kTextStyle1d,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField( 
                          controller: _reason_4_JoiningController,
                          maxLines: 5,
                          decoration: kInputField,
                          ),
                      ),
                        
                        SizedBox(height: 10),
                        
                      Text('How do you intend to help the farmers?', style: kTextStyle1d,),
                      SizedBox(height: 10),
                      TextField( 
                        controller: _how_u_HelpController,
                        maxLines: 5,
                        decoration: kInputField,
                        ),
                        
                      Expanded(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only( top: 8.0),
                              child: Checkbox(
                                activeColor: kColorPrimary,
                                value: isChecked, 
                                onChanged: (value){
                                  setState(() {
                                    isChecked = value!;
                                  });
                                }),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: Expanded(
                                child: RichText(
                                  
                                  text: TextSpan(
                                 text: 'Do you agree to help improve the knowlegde of farmers, to help them adopt modern farming methods and practices, leading to increased yield and  the production of healthy farm products?',
                                
                                style: TextStyle( fontSize: 14, fontWeight: FontWeight.w500, wordSpacing: 8),),
                                  ),
                              ),
                            )
                        
                            // increase the yield of farmers
                            // production of healthy, organic farm products
                            // help farmers to have acces to government support
                            // help farmers access quality information that will lead to production of qualtiy of produce
                            // build a community of farmers that supports one another
                            // it boosts the food production of the country
                          ],
                        ),
                      ),
                        
                      Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Back',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            )),
                        ElevatedButton(
                            onPressed: () async{
                              final snackbar1 = SnackBar(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            content: Text('Account Created Successfully', 
                            style: TextStyle(color: kColorPrimary,  fontSize: 16),),
                            backgroundColor: kColorSecondary,
                            duration: Duration(seconds: 5),
                            );
                          
                          setState(() {
                            isLoading = true;
                          });
                            try {
                              final data = {
                                'Why do you want to join' : _reason_4_JoiningController.text,
                                'How do you intend to help' : _how_u_HelpController.text
                              };
                        
                              await _firestore.collection('Farmers').doc(FireAuth().currentUser!.uid).set(data, SetOptions(merge: true));
                              await _firestore.collection('REO').doc(FireAuth().currentUser!.uid).set(data, SetOptions(merge: true));
                      
                              if (_reason_4_JoiningController.text != '' && isChecked == true) {
                                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                                  return WelcomeScreen();
                                })));
                              }
                      
                             ScaffoldMessenger.of(context).showSnackBar(snackbar1);
                            }  catch (e) {
                               print(e);
                      
                            final snackbar2 = SnackBar(
                            content: Text('${e}', 
                            style: TextStyle(color: kColorPrimary, fontSize: 16)),
                            backgroundColor: kColorSecondary,
                            duration: Duration(seconds: 5),
                            );
                      
                            setState(() {
                            isLoading  = false;
                          });
                      
                             ScaffoldMessenger.of(context).showSnackBar(snackbar2);
                      
                            }
                            },
                            child: Text('Next',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700)))
                      ],
                    ),
                  )
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