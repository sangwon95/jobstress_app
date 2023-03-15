// import 'package:flutter/material.dart';
// import 'package:jobstress/data/result.dart';
// import 'package:jobstress/page/result_page.dart';
// import 'package:jobstress/utils/color.dart';
// import 'package:jobstress/utils/common.dart';
//
// import 'answer.dart';
// import 'calculated.dart';
// import 'chat_data.dart';
// import 'gridview.dart';
//
// class ChatMessageItem extends StatefulWidget {
//   final ChatData chatData;
//   final AnimationController animationController;
//   final VoidCallback callback;
//   final int count;
//   final GridViewSelection gridViewSelection;
//   final Answer answer;
//   ChatMessageItem({this.chatData,this.animationController, this.callback,this.gridViewSelection, this.count, this.answer});
//
//
//   @override
//   _ChatMessageItemState createState() => _ChatMessageItemState();
// }
//
// class _ChatMessageItemState extends State<ChatMessageItem> {
//
//   final answerStandard = Answer();
//
//   int point = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.animationController != null ? _animationContainer(context) : _normalContainer(context);
//   }
//
//   Widget _normalContainer(context) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//
//           Container(
//               margin: EdgeInsets.symmetric(vertical: 10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   Container(child: SizedBox(width: 40.0, height: 40.0, child: Image.asset('user.png', fit: BoxFit.fill))),
//
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Container(
//                         padding: EdgeInsets.only(top: 8.0, right: 15.0, bottom: 8.0, left: 15.0),
//                         margin: EdgeInsets.only(top: 7, left: 8, right: 8),
//                         decoration: BoxDecoration(
//                             color: Color(0xFFEEEEEE),
//                             borderRadius:  BorderRadius.only(
//                                 topLeft: Radius.zero, topRight: Radius.circular(15.0), bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0)
//                             )
//                         ),
//                         constraints: BoxConstraints(
//                             maxWidth: MediaQuery.of(context).size.width / 1.6,
//                             minHeight: 30
//                         ),
//                         child: Text(widget.chatData.message, style: TextStyle(color: Color(0xFF363636))),
//                       ),
//
//                     ],
//                   ),
//                 ],
//               )
//           ),
//           widget.count == 18? Container(padding: EdgeInsets.only(top: 0, right: 40.0, left: 40.0, bottom: 10.0),
//               width: double.infinity,
//               height: 90,
//               child: Padding(padding: EdgeInsets.all(15.0),
//                 child: ElevatedButton(style: ElevatedButton.styleFrom(elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)), primary: mainColor),
//                     onPressed: () {
//
//                       Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> ResultPage(calculation())
//
//                       ));
//                     },
//                     child: Text('결과 학인하기', style: TextStyle(color: Colors.white, letterSpacing: 1.5, fontSize: 15.0, fontWeight: FontWeight.bold))),
//               )):
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               SizedBox(width: 40),
//               FittedBox(
//                 child: Container(
//                     padding: const EdgeInsets.fromLTRB(0, 7, 0, 30),
//                     child: SizedBox(
//                         width: 300,
//                         height: 100,
//
//                         child: GridView.builder(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: widget.gridViewSelection.selectionNames.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return buildGridViewSelect(index);
//                             },
//                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 1.0, mainAxisSpacing: 0, childAspectRatio: 2.9)))
//                 ),
//               ),
//             ],
//           )
//
//
//         ],
//       );
//   }
//
//
//   Widget _animationContainer(context) {
//     return SizeTransition(
//         sizeFactor: CurvedAnimation(
//             parent: widget.animationController,
//             curve: Curves.fastOutSlowIn
//         ),
//         axisAlignment: -1.0,
//         child: _normalContainer(context)
//     );
//   }
//
//   /// 선택지
//   Widget buildGridViewSelect (int index) {
//     String name = widget.gridViewSelection.selectionNames[index];
//     return GestureDetector(
//         onTap: () {
//           setState(() {
//
//             if (widget.gridViewSelection.isSelection[index]) {
//               widget.gridViewSelection.isSelection[index] = false;
//              // widget.answer.answer.add('');
//               widget.answer.answer[widget.count]= '';
//             } else  {
//               for(int i=0 ; i<widget.gridViewSelection.selectionNames.length ; i++){
//                 if(index != i){
//                   widget.gridViewSelection..isSelection[i] = false;
//                 }
//               }
//               widget.gridViewSelection.isSelection[index] = true;
//               widget.answer.answer[widget.count]= widget.gridViewSelection.selectionNames[index];
//               //widget.answer.answer.add(widget.gridViewSelection.selectionNames[index]);
//               widget.callback();
//
//             }
//
//           }
//           );},
//
//         child:Common.buildGridViewItem(name, widget.gridViewSelection.isSelection[index], index)
//     );
//   }
//
//   /// 점수 계산
//   Calculated calculation(){
//     Result result = Result();
//     for(int i = 0 ; i<widget.answer.answer.length ; i++){
//
//       if( widget.answer.answer[i] == answerStandard.veryGood)
//         point+=0;
//       else if( widget.answer.answer[i] == answerStandard.good)
//         point+=2;
//       else if( widget.answer.answer[i] == answerStandard.normal)
//         point+=3;
//       else if( widget.answer.answer[i] == answerStandard.bad)
//         point+=4;
//
//     }
//     if( point <= 10 )
//       return Calculated(result.greenGroup, result.green, result.greenComment, groupGreen, 'green.png');
//     else if( point <= 64)
//       return Calculated(result.yellowGroup, result.yellow, result.yellowComment, groupYellow, 'yellow.png');
//     else if( point <= 96)
//       return Calculated(result.redGroup, result.red, result.redComment, groupRed, 'red.png');
//
//     return Calculated(result.noneGroup, result.noneColor, result.noneComment, grayColorCustom, 'green.png');
//   }
// }
