import 'package:flutter/material.dart';

import '../main.dart';
import 'color.dart';

class Etc{

    //스넥바 메시지
  static showSnackBar(String meg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(meg, textScaleFactor: 0.9, style: TextStyle(color: Colors.white)), backgroundColor: mainColor,));
    }

  //map print
  static void getValuesFromMap(Map map) {
    // Get all values
    print('-----------------------');
    print('Map Get values:');
    map.entries.forEach((entry){
      mLog.d('${entry.key} : ${entry.value}');
    });
    print('-----------------------');
  }

  static int checkAnswerLength(int answerLength) {
    int crossAxisCountValue;
    if (answerLength < 3) {
      return crossAxisCountValue = 1;
    } else if (answerLength < 5) {
      return crossAxisCountValue = 2;
    } else {
      return crossAxisCountValue = 3;
    }
  }

  // font scale
  static MediaQueryData getScaleFontSize(BuildContext context, {double fontSize}){
    final mqData = MediaQuery.of(context);
    return mqData.copyWith(textScaleFactor: fontSize);
  }
}