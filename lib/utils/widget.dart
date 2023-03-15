import 'package:flutter/material.dart';

import 'color.dart';

class ChooseGender extends StatelessWidget {

  final String name;
  final bool isGender;
  ChooseGender({this.name, this.isGender});

  @override
  Widget build(BuildContext context) {
    return  Stack(
        children: <Widget>[
          Card(
            color:  Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),side:BorderSide(width:2, color: isGender ? mainColor : grayColorCustom)),
            child: Container(height: 20,
              child: Center(child: Text(name, textScaleFactor:0.8, style: TextStyle(color: isGender ? mainColor : grayColorCustom))),
          ),
        ),
    ]
    );
  }
}
