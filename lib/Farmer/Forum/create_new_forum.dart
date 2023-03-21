import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_connect/Firebase/fire_auth.dart';
import 'package:farmers_connect/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NewForum extends StatefulWidget {
  const NewForum({super.key});

  @override
  State<NewForum> createState() => _NewForumState();
}

class _NewForumState extends State<NewForum> {
  final _firestore = FirebaseFirestore.instance;
  
  TextEditingController _nameController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: kColorPrimary,
                  ),
                  child: Text('Create New Forum',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                    ),
                    ),
                ),
              ),
        
              Text('Name'),
              TextField(
                controller: _nameController,
                decoration: kInputField,
              ),
              SizedBox(height: 20,),
              Text('About'),
              TextField(
                maxLines: 4,
                controller: _aboutController,
                decoration: kInputField,
              ),
    
              SizedBox(height: 50,),
              ElevatedButton(
                onPressed: (){
                  String forumName = _nameController.text;
                  final message = <String, dynamic>{
                  'Title': _nameController.text,
                  'About': _aboutController.text,
                  'Forum_id': _nameController.text,
                  'Created by': FireAuth().currentUser?.email,
                  'time': TimeOfDay.fromDateTime(DateTime.now()).toString()
                };
                _firestore.collection('Forums').doc(forumName).set(message);
    
                setState(() {
                Navigator.of(context);
                  
                });
                
                }, 
                child: Text('Create',
                     style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600)
                 ),
                 style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20)
                 ),
                )
            ],
          ),
        ),
      ),
    );
  }
}