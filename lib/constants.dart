import 'package:flutter/material.dart';

const kColorPrimary = Color(0xFF026706);
// const kColorPrimary = Color.fromRGBO(2, 103, 6, 1.0);

const kColorSecondary = Color.fromRGBO(232, 245, 233, 1);

const kLogoTextStyle1 =
    TextStyle(fontSize: 24, fontWeight: FontWeight.w600, fontFamily: 'Poppins');

const kLogoTextStyle2 = TextStyle(
    fontSize: 13,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
    color: Color.fromARGB(255, 0, 10, 1));

const kLogoTextStyle2b = TextStyle(
  color: Colors.white,
  fontSize: 13,
  fontStyle: FontStyle.italic,
  fontWeight: FontWeight.w300,
  fontFamily: 'Poppins',
  height: 1.0,
);

const kLogoTextStyle1b = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  fontFamily: 'Poppins',
  color: Colors.white,
);

const kTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    hintText: 'Email address',
    hintStyle: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: Color.fromRGBO(232, 245, 233, 1),
    
    
    // border: OutlineInputBorder(
    //   borderRadius: BorderRadius.all(Radius.circular(10)),
    //   borderSide: BorderSide(
    //     color: kTextColor,
    //   ),
    // )
    );

const kTextFieldDecoration2 = InputDecoration(
    hintStyle: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    hintText: 'Password',
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none,
    ),
   filled: true,
    fillColor: Color.fromRGBO(232, 245, 233, 1),
   );

const kTextFieldDecoration3 = InputDecoration(
    hintStyle: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
    hintText: 'Email address',
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none,
    ),
   filled: true,
    fillColor: Color.fromRGBO(232, 245, 233, 1),
   );

const kTextColor = Color.fromRGBO(105, 105, 105, 1);

const kTextColor2 = Color.fromARGB(255, 187, 183, 183);

const kTextStyle1 = TextStyle(
    fontSize: 18,
    color: kColorPrimary,
    fontWeight: FontWeight.w700,
    fontFamily: 'Montserrat');

const kTextStyle1c = TextStyle(
    fontSize: 18,
    color: kTextColor,
    fontWeight: FontWeight.w700,
    fontFamily: 'Montserrat');

const kTextStyle1d = TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontFamily: 'Montserrat');

const kTextStyle2 = TextStyle(
  color: kColorPrimary,
  fontSize: 16,
  fontWeight: FontWeight.w400,
  fontFamily: 'Montserrat',
  height: 2,
);

const kShadow = [
  BoxShadow(
    color: Color.fromARGB(255, 184, 182, 182),
    spreadRadius: 1,
    blurRadius: 5,
    // blurStyle: BlurStyle.outer
  )
];

const kInputField = InputDecoration(
    hintStyle: TextStyle(fontFamily: 'Montserrat'),
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
    ));



const kSelect = InputDecoration(
    hintText: 'Select',
    hintStyle: TextStyle(fontFamily: 'Montserrat'),
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
    ));
