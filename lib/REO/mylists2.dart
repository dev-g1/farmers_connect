
import 'package:flutter/material.dart';

class MyLists2 {

 
  
  List regions = [
    'North West',
    'North East',
    'North Central',
    'South West',
    'South East',
    'South South'
  ];

  List expertise = [
    'Pest management',
    'Livestock management',
    'Feeds',
    'Research',
    'Health management',
    'Others',
  ];

  List experience = [
    '0-1 year',
    '1-3 years',
    '3-5 years',
    '5 years - above'
  ];

  List<DropdownMenuItem> getRegion(){
    List<DropdownMenuItem<String>> menuRegions = [];

    for (var i = 0; i < regions.length; i++)  {
        String myRegion = regions[i];
        final _region = DropdownMenuItem(
        value: myRegion,
        child: Text(myRegion));

      menuRegions.add(_region);
    }
      return menuRegions;
  }

  List<DropdownMenuItem> getExperience(){
    List<DropdownMenuItem<String>> menuExperience = [];

    for (var i = 0; i < experience.length; i++)  {
        String myExperience = experience[i];
        final _experience = DropdownMenuItem(
        value: myExperience,
        child: Text(myExperience));

      menuExperience.add(_experience);
    }
      return menuExperience;
  }

  List<DropdownMenuItem> getExpertise(){
    List<DropdownMenuItem<String>> menuExpertise = [];

    for (var i = 0; i < expertise.length; i++)  {
        String myExpertise = expertise[i];
        final _expertise = DropdownMenuItem(
        value: myExpertise,
        child: Text(myExpertise));

      menuExpertise.add(_expertise);
    }
      return menuExpertise;
  }

}