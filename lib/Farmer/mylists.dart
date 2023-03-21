
import 'package:farmers_connect/Farmer/Chat/chatting.dart';
import 'package:farmers_connect/Farmer/Forum/my_forums.dart';
import 'package:farmers_connect/constants.dart';
import 'package:farmers_connect/models/chatMessageModel.dart';
import 'package:farmers_connect/models/chatUsersModel.dart';
import 'package:farmers_connect/models/forumsModel.dart';
import 'package:flutter/material.dart';

class MyLists {




List states = [
  'Select',
 'Abia',
'Adamawa',
'Akwa Ibom',
'Anambra',
'Bauchi',
'Bayelsa',
'Benue',
'Borno',
'Cross River',
'Delta',
'Ebonyi',
'Edo',
'Ekiti',
'Enugu',
'Gombe',
'Imo',
'Jigawa',
'Kaduna',
'Kano',
'Kebbi',
'Kogi',
'Kwara',
'Lagos',
'Nasarawa',
'Niger',
'Ogun',
'Ondo',
'Oyo',
'Plateau',
'Rivers',
'Sokoto',
'Taraba',
'Yobe',
'Zamfara',
'Federal Capital Territory'

];


List<DropdownMenuItem> dropDownMenu(){
  // for (var state in states) {
  //   DropdownMenuItem(
  //     value: '$state',
  //     child: Text('$state'),
  //     );
  // }
  List<DropdownMenuItem<String>> statesList = [];
  for (var i = 0; i < states.length; i++) {
    String state = states[i];
   final statesDropDownMenu = DropdownMenuItem(
      value: state,
      child: Text(state),
      );
  statesList.add(statesDropDownMenu);
  }
  
  return statesList;

}


  List<ChatUsers> chatUsers = [
    ChatUsers( "Jane Russel" ,"Awesome Setup",  "images/userImage1.jpeg",  "Now"),
    ChatUsers( "Glady's Murphy",  "That's Great",  "images/userImage2.jpeg",  "Yesterday"),
    ChatUsers( "Jorge Henry",  "Hey where are you?",  "images/userImage3.jpeg",  "31 Mar"),
    ChatUsers( "Philip Fox",  "Busy! Call me in 20 mins",  "images/userImage4.jpeg",  "28 Mar"),
    ChatUsers( "Debra Hawkins",  "Thankyou, It's awesome",  "images/userImage5.jpeg",  "23 Mar"),
    ChatUsers( "Jacob Pena",  "will update you in evening",  "images/userImage6.jpeg",  "17 Mar"),
    ChatUsers( "Andrey Jones",  "Can you please share the file?",  "images/userImage7.jpeg",  "24 Feb"),
    ChatUsers( "John Wick",  "How are you?",  "images/userImage8.jpeg",  "18 Feb"),
  ];

  List<ChatMessage> messages = [
    ChatMessage( "Hello, Will",  "receiver"),
    ChatMessage( "How have you been?",  "receiver"),
    ChatMessage( "Hey Kriss, I am doing fine dude. wbu?",  "sender"),
    ChatMessage( "ehhhh, doing OK.",  "receiver"),
    ChatMessage( "Is there any thing wrong?",  "sender"),
  ];

  List<Forum> forums = [
    Forum('Modern Farm Practices', 'Here we learn about modern farm practices such crop rotation, irrigation etc.'),
    Forum('Feeding', 'This is for all talk relating to feeding'),
    Forum('Pests and parasites', 'This is for all talk relatng to feeding'),
    // REO will be able to create group
  ];
    

  
    
}