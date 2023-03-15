// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:jobstress/data/answer.dart';
// import 'package:jobstress/data/chat_data.dart';
// import 'package:jobstress/data/chat_message_item.dart';
// import 'package:jobstress/data/gridview.dart';
// import 'package:jobstress/data/question.dart';
// import 'package:jobstress/utils/color.dart';
//
// class ChatPage extends StatefulWidget {
//
//   @override
//   _ChatPageState createState() => _ChatPageState();
// }
//
// class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
//   final List<ChatMessageItem> _messageItemList = [];
//
//   int count = 0;
//
//   List<GridViewSelection> gridGroup = []; // 응답 선택문항 Group
//
//   final _question = Question(); // 질문지
//   Answer _answer = Answer();   // 응답
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     for(int i = 0 ; i<26 ; i++){
//       gridGroup.add(GridViewSelection(selectionNames:[ '전혀 그렇지 않아', '그렇지 않아', '그런 편이야', '매우 그렇지' ],isSelection:[ false, false, false, false ]));
//     }
//     onReceiveData();
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text('직무스트레스 검사',style: TextStyle(color: Colors.white, fontSize: 16)),
//           backgroundColor: mainColor,
//           iconTheme: IconThemeData(
//             color: Colors.white, //change your color here
//           ),
//         ),
//         body: Stack(
//           children: [
//             Container(margin: EdgeInsets.only(top: 1),
//               child: Column(
//                 children: [
//
//                   Flexible(
//                     child: ListView.builder(
//                       padding: EdgeInsets.all(8.0),
//                       reverse: true,
//                       itemBuilder: (context, index) => _messageItemList[index],
//                       itemCount: _messageItemList.length,
//                     ),
//                   ),
//
//                   Divider(height: 1.0),
//                 ],
//               ),
//             ),
//
//           ],
//         )
//     );
//   }
//
//   void onReceiveData() {
//     final questionChatData = ChatData();
//     questionChatData.message = _question.contents[count];
//
//     ChatMessageItem messageItem = ChatMessageItem(chatData: questionChatData,
//         animationController:AnimationController(duration: Duration(milliseconds:100), vsync: this),
//         gridViewSelection:gridGroup[count], callback: ()=>onReceiveData(), count:count, answer:_answer);
//
//     setState(() {
//       _messageItemList.insert(0, messageItem);
//       count++;
//     });
//     messageItem.animationController.forward();
//   }
//
// }
