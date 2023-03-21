// import 'dart:io';

// import 'package:farmers_connect/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class SendMessage extends StatefulWidget {
  
//    SendMessage(this.onPressed, this.controller);
//   void Function() onPressed;


//   @override
//   State<SendMessage> createState() => _SendMessageState();
// }

// class _SendMessageState extends State<SendMessage> {
//     TextEditingController controller;

//    File? _photo;
//   final ImagePicker _picker = ImagePicker();

//    Future imgFromGallery() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {
//         _photo = File(pickedFile.path);
//         uploadFile();
//       } else {
//         print('No image selected');
//       }
//     });

//   }
//   Future imgFromCamera() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.camera);

//     setState(() {
//       if (pickedFile != null) {
//         _photo = File(pickedFile.path);
//         uploadFile();
//       } else {
//         print('No image selected');
//       }
//     });

//   }
//   Future uploadFile() async {
//     if (_photo == null) return;
//     final fileName = basename(_photo!.path);
//     final destination = 'files/$fileName';

//     try {
//       final ref = _fireStorage.ref(destination).child('file/');
//       await ref.putFile(_photo!);
//     } catch (e) {
//       print(e);
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
   

//     TextEditingController messageController = TextEditingController();
//     return Container(
//       padding: EdgeInsets.only(left: 10),
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: kColorPrimary,
//             blurRadius: 3,
//             blurStyle: BlurStyle.outer,
//             spreadRadius: 1,
//           )
//         ]
//       ),
//       child: Row(
//         // crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           GestureDetector(
//             onTap: (){
//               showModalBottomSheet(
//                 context: context, 
//                 builder: (BuildContext bc){
//                   return SafeArea(
//                     child: Wrap(
//                       children: [
//                         ListTile(
//                           leading: Icon(Icons.photo_library),
//                           title: Text('Gallery'),
//                           onTap: (){
//                             imgFromGallery();
//                           },
//                         ),
//                         ListTile(
//                           leading: Icon(Icons.photo_camera),
//                           title: Text('Camera'),
//                           onTap: (){
//                             imgFromCamera();
//                           },
//                         )
//                       ],
//                     ));
//                 });
//             },
//             child: Icon(Icons.photo)),
          
//            Expanded(
//              child: Container(
//                child: TextField(
//                 controller: widget.controller,
//                 decoration: InputDecoration(
//                   hintText: 'Message',
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide.none
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide.none,
//                   ),
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide.none
//                   )
//                 )),
//              )
//            ),
              
//           Padding(
//             padding: const EdgeInsets.only(bottom: 10.0, right: 10),
//             child: GestureDetector(
//               onTap: widget.onPressed,
//               child: Container(
//                 padding: EdgeInsets.all(4),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: kColorPrimary,
//                 ),
//                   child: Icon(Icons.send_rounded, color: Colors.white,)
//                ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }