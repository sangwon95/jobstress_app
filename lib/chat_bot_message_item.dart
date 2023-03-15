import 'package:flutter/material.dart';
import 'package:jobstress_app/page/result_page.dart';
import 'package:jobstress_app/utils/common.dart';
import 'package:jobstress_app/utils/constants.dart';
import '../utils/color.dart';
import 'data/calculated.dart';
import 'data/chat_bot_model.dart';
import 'data/request_chat_data.dart';
import 'data/result.dart';
import 'main.dart';


/// ChatBot Message Item Widget
// ignore: must_be_immutable
class  ChatBotMessageItem extends StatefulWidget {

  final ChatBotModel chatBotModel;
  final AnimationController animationController;
  final Function(RequestChatData) callback;
  final List<bool> isSelectColor;
  bool runOnce;
  ChatBotMessageItem({this.chatBotModel,  this.animationController, this.callback, this.isSelectColor, this.runOnce});

  @override
  _ChatBotMessageItemState createState() => _ChatBotMessageItemState();
}

class _ChatBotMessageItemState extends State<ChatBotMessageItem> {

  @override
  Widget build(BuildContext context) {
    return _animationContainer(context);
  }

  Widget _normalContainer(context) {
    return widget.chatBotModel.messageUIType == 'RECEIVE' ?

    /// 받은 메시지 widget
    Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Container(
                child: SizedBox(width: 55.0, height: 55.0,
                    child: Image.asset('user.png', fit: BoxFit.fill))),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:
              [
                Container(
                  padding: EdgeInsets.only(top: 8.0, right: 15.0, bottom: 8.0, left: 15.0),
                  margin: EdgeInsets.only(top: 7, left: 8, right: 8),
                  decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.zero, topRight: Radius.circular(15.0), bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0)
                      )
                  ),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 1.5,
                    minHeight: 30,

                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(widget.chatBotModel.questionMessage == 'GREEN' || widget.chatBotModel.questionMessage == 'YELLOW' || widget.chatBotModel.questionMessage == 'RED' ?
                      '검사가 종료되었습니다.': widget.chatBotModel.questionMessage, textScaleFactor: 1.0, style: TextStyle(color: Colors.white)),

                      Visibility(
                        visible:  widget.chatBotModel.questionMessage == 'GREEN' || widget.chatBotModel.questionMessage == 'YELLOW' || widget.chatBotModel.questionMessage == 'RED' ? true : false,
                        child: Container(
                            padding: EdgeInsets.only(top: 10),
                            width:MediaQuery.of(context).size.width / 1.8,
                            height: 55,
                            child: Padding(padding: EdgeInsets.all(4.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
                                      primary: Colors.white
                                  ),
                                  onPressed: ()
                                  {
                                    //Navigator.pop(context);
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> ResultPage(calculation(widget.chatBotModel.questionMessage))));
                                  },
                                  child: Text('결과 확인', textScaleFactor: 1.1, style: TextStyle(color: mainColor, letterSpacing: 1.5, fontWeight: FontWeight.bold))),
                            )),
                      ),

                      Visibility(
                        visible: widget.chatBotModel.questionMessage == '설문종료' ? true : false,
                        child: Container(
                            padding: EdgeInsets.only(top: 10),
                            width:MediaQuery.of(context).size.width / 1.8,
                            height: 55,
                            child: Padding(padding: EdgeInsets.all(4.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
                                      primary: Colors.white
                                  ),
                                  onPressed: ()
                                  {
                                    Navigator.pop(context);
                                  },
                                  child: Text('나가기', textScaleFactor: 1.1, style: TextStyle(color: mainColor, letterSpacing: 1.5, fontWeight: FontWeight.bold))),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            )
          ]
        )
    )
    :
    /// 선택지 widget
    Container(
        margin: EdgeInsets.only(top: 5, bottom: 50),
        child: Row(
          mainAxisAlignment:  MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                Container(
                  height: widget.chatBotModel.chatAnswersList.length == 5 ? 290 : widget.chatBotModel.chatAnswersList.length == 2 ? 140 : 240,
                  padding: EdgeInsets.only(right: 15.0,  left: 15.0),
                  margin: EdgeInsets.only(left: 8, right: 8),
                  decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.zero, bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
                  ),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 1.6,
                      minWidth: 30
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:
                    [
                      GridView.builder(
                          padding: EdgeInsets.only(bottom: 20),
                          shrinkWrap: true,
                          reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.chatBotModel.chatAnswersList.length,
                          itemBuilder: (BuildContext context, int index)
                          {
                            return buildGridViewSelect(index);
                          },
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 50,
                              crossAxisCount: 1,
                              crossAxisSpacing: 0.0,
                              mainAxisSpacing: 0,
                              childAspectRatio: 1.0
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }


  /// Chat Item Animation widget
  Widget _animationContainer(context) {
    return SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: widget.animationController,
            curve:  Curves.fastOutSlowIn),
        axisAlignment: -1.0,
        child: _normalContainer(context)
    );
  }


  // 선택지
  Widget buildGridViewSelect (int index) {
    return GestureDetector(
        onTap: () {

          // ChatSelect select = ChatSelect(
          //     questionNo:int.parse(widget.chatData.questionNo),
          //     answerNo:widget.chatData.chatAnswersData[index].answerNo,
          //     answerMessage:widget.chatData.chatAnswersData[index].answerMessage
          // );

          RequestChatData requestChatData = RequestChatData(
              userIdx:  widget.chatBotModel.userIdx,
              questionNo: int.parse(widget.chatBotModel.questionNo),
              answerNo: widget.chatBotModel.chatAnswersList[index].answerNo ,
              answerMessage: widget.chatBotModel.chatAnswersList[index].answerMessage
          );

          print('questionNo: ${widget.chatBotModel.questionNo}');
          print('answerNo: ${widget.chatBotModel.chatAnswersList[index].answerNo}');
          print('answerMessage: ${widget.chatBotModel.chatAnswersList[index].answerMessage}');

          setState(() {
            if(widget.runOnce)
            {
              widget.isSelectColor[index] = true;
              widget.runOnce = false;
              widget.callback(requestChatData); // ChatPage 로 넘어가는 값
            }
          });
        },
        child:Common.buildChatGridViewItem(widget.chatBotModel.chatAnswersList[index].answerMessage, widget.isSelectColor[index])
    );
  }

  Calculated calculation(String msg){
    Result result = Result();

    if(msg == 'GREEN')
      return Calculated(result.greenGroup, result.green, result.greenComment, groupGreen, 'green.png');
    else if(msg == 'YELLOW')
      return Calculated(result.yellowGroup, result.yellow, result.yellowComment, groupYellow, 'yellow.png');
    else if(msg == 'RED')
      return Calculated(result.redGroup, result.red, result.redComment, groupRed, 'red.png');

    return Calculated(result.noneGroup, result.noneColor, result.noneComment, grayColorCustom, 'green.png');
  }
}
