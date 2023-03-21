// ignore_for_file: camel_case_types

import 'package:farmers_connect/Farmer/sign_up_tab1.dart';
import 'package:farmers_connect/Firebase/fire_auth.dart';
import 'package:farmers_connect/REO/Sign-up/signup2.dart';
import 'package:farmers_connect/constants.dart';
import 'package:farmers_connect/Farmer/mylists.dart';
import 'package:flutter/material.dart';
import 'package:farmers_connect/REO/mylists2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


 MyLists2 myLists2 = MyLists2();
class REO_Sign_Up1 extends StatefulWidget {
  const REO_Sign_Up1({super.key});

  @override
  State<REO_Sign_Up1> createState() => _REO_Sign_Up1State();
}

class _REO_Sign_Up1State extends State<REO_Sign_Up1> {
   String? state;
   String? region;
   String? expertise;
   String? experience;
   TextEditingController _nameController = TextEditingController();
  

  final _firestore = FirebaseFirestore.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: prefer_const_constructors
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(child: Text('REO / Agricultural  Expert\'s  Information', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),), decoration: BoxDecoration(color: kColorPrimary),width: MediaQuery.of(context).size.width, padding: EdgeInsets.symmetric(vertical: 15 ,horizontal: 18),),
              ),
              TextField1('Full Name'),
              TextField(
                controller: _nameController,
                decoration: kInputField),
              TextField1('State'),
              Container(
                padding: EdgeInsets.symmetric( horizontal: 20),
                height: 35,
                decoration: BoxDecoration(
                    border: Border.all(color: kTextColor, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton(
                    isExpanded: true,
                    hint: Text('Select'),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: kTextColor,
                        fontSize: 16),
                    underline: Container(),
                    value: state,
                    iconEnabledColor: kColorPrimary,
                    items: getMyLists.dropDownMenu(),
                    
                    onChanged: (value) {
                      setState(() {
                        state = value;
                      });
                    }),
              ),
              TextField1('Region'),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                height: 35,
                decoration: BoxDecoration(
                    border: Border.all(color: kTextColor, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton(
                    isExpanded: true,
                    hint: Text('Select'),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: kTextColor,
                        fontSize: 16),
                    underline: Container(),
                    value: region,
                    iconEnabledColor: kColorPrimary,
                    items: myLists2.getRegion(),
                    onChanged: (value) {
                      setState(() {
                        region = value;
                      });
                    }),
              ),
              
              TextField1('Area of expertise'),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                height: 35,
                decoration: BoxDecoration(
                    border: Border.all(color: kTextColor, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton(
                    isExpanded: true,
                    hint: Text('Select'),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: kTextColor,
                        fontSize: 16),
                    underline: Container(),
                    value: expertise,
                    iconEnabledColor: kColorPrimary,
                    items: myLists2.getExpertise(),
                    onChanged: (value) {
                      setState(() {
                        expertise = value;
                      });
                    }),
              ),
              TextField1('Years of experience'),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                height: 35,
                decoration: BoxDecoration(
                    border: Border.all(color: kTextColor, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton(
                    isExpanded: true,
                    hint: Text('Select'),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: kTextColor,
                        fontSize: 16),
                    underline: Container(),
                    value: experience,
                    iconEnabledColor: kColorPrimary,
                    items: myLists2.getExperience(),
                    onChanged: (value) {
                      setState(() {
                       experience = value;
                      });
                    }),
              ),
              
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 20),
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
                              color: kColorPrimary,
                              fontWeight: FontWeight.w700),
                        )),
                    ElevatedButton(
                        onPressed: () async{
                             final data = {
                              'username': 'REO - ' +  _nameController.text,
                              'state' : state,
                             'region': region,
                             'expertise': expertise,
                             'experience': experience,
                             'user?' : 'REO',
                             'id' : FireAuth().currentUser!.uid
                          };
                            await _firestore.collection('Farmers').doc(FireAuth().currentUser!.uid).set(data);
                            await _firestore.collection('REO').doc(FireAuth().currentUser!.uid).set(data);
              
                            if (_nameController.text != '') {
                              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                                return REO_Sign_Up2();
                              })));
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
    );
  }
}