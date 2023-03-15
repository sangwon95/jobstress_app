import 'package:flutter/material.dart';

import 'color.dart';
import 'etc.dart';




class InputEdit extends StatelessWidget {

  final IconData iconData;
  final String hint;
  final String type;
  final String headText;
  final TextEditingController controller;

  InputEdit({this.iconData, this.hint, this.controller, this.type, this.headText });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Text(headText, textScaleFactor: 1.0, style: TextStyle( fontWeight: FontWeight.bold)),
        ),

        Container(
            alignment: Alignment.centerLeft,
            height: 60.0,
            child: MediaQuery(
              data: Etc.getScaleFontSize(context, fontSize: 0.85),
              child: TextField(
                autofocus: false,
                controller: controller,
                keyboardType: type =='number' ? TextInputType.number:TextInputType.text,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: new OutlineInputBorder(borderRadius: const BorderRadius.all(const Radius.circular(10.0))),
                    contentPadding: EdgeInsets.only(top: 0.0),
                    fillColor: Colors.red,
                    hoverColor: mainColor,
                    prefixIcon: Icon(iconData, color: mainColor),
                    hintText: hint,
                    hintStyle: TextStyle(color: Colors.grey)
                ),
              ),
            )
        )

      ],
    );
  }
}