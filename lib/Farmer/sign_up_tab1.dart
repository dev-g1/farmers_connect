import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_connect/Common%20Pages/welcomescreen.dart';
import 'package:farmers_connect/Farmer/sign_up_2.dart';
import 'package:farmers_connect/Firebase/fire_auth.dart';
import 'package:farmers_connect/constants.dart';
import 'package:farmers_connect/Farmer/mylists.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

MyLists getMyLists = MyLists();
class FarmerSignUp_01 extends StatefulWidget {
  @override
  State<FarmerSignUp_01> createState() => _FarmerSignUp_01State();

}


class _FarmerSignUp_01State extends State<FarmerSignUp_01> {
  String? selectScale;
  String? selectTypeof;
  String? state;

  bool isLoading = false;
  final _firestore = FirebaseFirestore.instance;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _specialNeedsController = TextEditingController();
  
@override

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 15),
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(child: Text('Farmer\'s Information', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),), decoration: BoxDecoration(color: kColorPrimary),width: MediaQuery.of(context).size.width, padding: EdgeInsets.symmetric(vertical: 10 ,horizontal: 20),),
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
                  TextField1('Type of farming'),
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
                        value: selectTypeof,
                        iconEnabledColor: kColorPrimary,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'Select',
                              style: TextStyle(
                                  fontFamily: 'Montserrat', color: kTextColor),
                            ),
                            value: 'Select',
                          ),
                          DropdownMenuItem(
                            child: Text('Crop'),
                            value: 'Crop',
                          ),
                          DropdownMenuItem(
                            child: Text('Fish'),
                            value: 'Fish',
                          ),
                          DropdownMenuItem(
                            child: Text('Animal'),
                            value: 'Animal',
                          )
                        ],
                        onTap: () {},
                        onChanged: (value) {
                          setState(() {
                            selectTypeof = value;
                          });
                        }),
                  ),
                  TextField1('Scale of farming'),
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
                        value: selectScale,
                        iconEnabledColor: kColorPrimary,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'Select',
                              style: TextStyle(
                                  fontFamily: 'Montserrat', color: kTextColor),
                            ),
                            value: '- Select',
                          ),
                          DropdownMenuItem(
                            child: Text('Small'),
                            value: 'Small',
                          ),
                          DropdownMenuItem(
                            child: Text('Large'),
                            value: 'Large',
                          )
                        ],
                        onTap: () {},
                        onChanged: (value) {
                          setState(() {
                            selectScale = value;
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text('Special needs', style: kTextStyle1d,),
                  ),
                  TextField(
                    controller: _specialNeedsController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Do you have special needs?',
                      hintStyle: TextStyle(fontSize: 14),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: kTextColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: kColorPrimary,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0, bottom: 10),
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
                            padding: EdgeInsets.all(20),
                            content: Text('Account created Successfully', 
                            style: TextStyle(color: kColorPrimary,  fontSize: 16),),
                            backgroundColor: kColorSecondary,
                            duration: Duration(seconds: 5),
                            );
                          
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            final data = <String, dynamic>{
                                  'id' : FireAuth().currentUser!.uid,
                                  'username': _nameController.text,
                                  'state' : state,
                                  'farming_type' : selectTypeof,
                                  'farming_scale' : selectScale,
                                  'needs' : _specialNeedsController.text ,
                                  'user?' : 'Farmer'
                              };
                             await  _firestore.collection('Farmers').doc(FireAuth().currentUser!.uid).set(data);
                              if (_nameController.text != '' ){
                              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                                return WelcomeScreen();
                              })));
                
                              ScaffoldMessenger.of(context).showSnackBar(snackbar1);
                              }
                          } on FirebaseException catch (e) {
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
                            setState(() {});
                             ScaffoldMessenger.of(context).showSnackBar(snackbar2);
                            
                          };
                          },
                            child: Text('Save',
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

class TextField1 extends StatelessWidget {
  String fieldValue;

  TextField1(this.fieldValue);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        fieldValue,
        style: kTextStyle1d,
      ),
    );
  }
}
