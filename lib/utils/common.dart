import 'package:flutter/material.dart';

import 'color.dart';
import 'constants.dart';
class Common{

 static doAppBar(String title) {
   return AppBar(
     iconTheme: IconThemeData(color: Colors.white),
     backgroundColor: mainColor,
     title: Text(title, textScaleFactor: 0.9, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
     centerTitle: true,
 );
 }
 static buildGridViewItem(String name, bool isGender, int index){
   return  Padding(
     padding: const EdgeInsets.all(1),
     child: Card(
       color:  isGender ? mainColor: Colors.white,
       elevation: 0,
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side:BorderSide(
         width:1,
         color: isGender ? mainColor : grayColorCustom,
       )),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.start,
         children:
         [
           SizedBox(width: 10),

           Image.asset(index.toString()+'.png',width: 20,height: 20,fit: BoxFit.fill,color: isGender ? Colors.white : Colors.grey),

           SizedBox(width: 10),

           Text(name, style: TextStyle(color: isGender ? Colors.white : Colors.grey, fontSize: 13, fontWeight: FontWeight.bold)),
       ],
       )

     ),
   );
 }

 // static buildGridViewItem2(String name, bool isGender){
 //   return  Stack(
 //     children: <Widget>[
 //       Card(
 //         color:Colors.white,
 //         elevation: 0,
 //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),side:BorderSide(width:1.5, color: isGender ? mainColor : grayColorCustom)),
 //         child: Container(height: 42,
 //           child: Center(child: Text(name, textScaleFactor:0.8, style: TextStyle(color: isGender ? mainColor : grayColorCustom))),
 //         ),
 //       ),
 //     ],
 //   );
 // }
 static buildGridViewItem2(String name, bool isGender){
   return  Stack(
     children: [
       Padding(
         padding: const EdgeInsets.all(1),
         child: Card(
           color:  Colors.white,
           elevation: 0,
           shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(10),
               side:BorderSide(width:isGender ? 1.7 : 1.0, color: isGender ? mainColor : grayColorCustom)),
           child: Container(height: 42,
             child: Center(
                 child: Text(name, textScaleFactor: isGender ? 1.0 : 0.8,
                     style: TextStyle(
                         color: isGender ? mainColor : grayColorCustom,
                          fontWeight:  isGender ? FontWeight.w800 : FontWeight.normal
                     ))),
           ),
         ),
       ),
     ],
   );
 }


 //큰 사이즈 로고
 static doLogo({BuildContext context, double height}){
   return
     Container(
       width: MediaQuery.of(context).size.width,
       child: Center(
           child: Image.asset('images/bi.png', height: 200, width: height/1.5)),
     );
 }

 //채팅 선택지
 static buildChatGridViewItem(String name, bool isSelectColor){
   return  Card(
       color: Colors.white,
       elevation: 0,
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),
           side:BorderSide(width: isSelectColor? 2.0 : 1.0, color: isSelectColor? mainColor: Colors.grey)),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Container(
               width: 180,
               padding: EdgeInsets.only(left: 5, right: 5),
               child: Center(child: Text(name, textScaleFactor: 0.9,
                   style: TextStyle(
                       color: isSelectColor? mainColor: Colors.grey,
                       fontWeight: isSelectColor? FontWeight.w600 : FontWeight.normal)))),
         ],
       )
   );
 }

 /// 채팅 말풍선
 static Container speechBubble({
    BuildContext context,
    Color backgroundColor,
    String msgType,
    String chatMessage,
    Color textColor,
   double fontSize = 1.0,
   Function() endButtonFunction,
   FontWeight fontWeight = FontWeight.normal}){

   return Container(
     margin: EdgeInsets.only(top: 12, left: 8, right: 8),
     padding: EdgeInsets.only(top: 8.0, right: 15.0, bottom: 8.0, left: 15.0),
     constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.6, minHeight: 30),
     decoration: BoxDecoration(
         color: backgroundColor,
         borderRadius: msgType == MessagePosition.right ?
         BorderRadius.only(
             topLeft: Radius.circular(15.0),
             topRight: Radius.zero,
             bottomLeft: Radius.circular(15.0),
             bottomRight: Radius.circular(15.0))
             :
         BorderRadius.only(
             topLeft: Radius.zero,
             topRight: Radius.circular(15.0),
             bottomLeft: Radius.circular(15.0),
             bottomRight: Radius.circular(15.0))
     ),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children:
       [
         Text(chatMessage, textScaleFactor: fontSize, style: TextStyle(color: textColor, fontWeight: fontWeight)),

         /// BurnoutChatBot, ChatBot 종료 버튼
         /// #issue:  BurnoutChatBot 의 전문상담가 연결 서비스가 없어 contains 를 통해 홈화면으로 이동한다.
         Visibility(
           visible: false,
           child: Container(
               padding: EdgeInsets.only(top: 10),
               width:MediaQuery.of(context).size.width / 1.8,
               height: 55,
               child: Padding(
                 padding: EdgeInsets.all(4.0),
                 child: ElevatedButton(
                     style: ElevatedButton.styleFrom(elevation: 2,
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                         primary: Colors.white),
                     onPressed: () async
                     {

                     },
                     child: Text('검사 종료', textScaleFactor: 1.0, style: TextStyle(color: mainColor, letterSpacing: 1.5, fontWeight: FontWeight.bold))),
               )),
         )
       ],
     ),
   );
   //);
 }
}