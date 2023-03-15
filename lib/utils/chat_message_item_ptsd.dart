import 'package:flutter/material.dart';
import 'package:jobstress_app/data/calculated.dart';
import 'package:jobstress_app/data/chat_select.dart';
import 'package:jobstress_app/data/result.dart';
import 'package:jobstress_app/page/result_page.dart';
import '../data/chat_data.dart';
import 'color.dart';
import 'common.dart';

// ptsd message
// ignore: must_be_immutable
class ChatMessageItemPTSD extends StatefulWidget {
  final ChatDataPTSD chatData;
  final AnimationController animationController;
  final Function(ChatSelect) callback;
  final List<bool>isSelectColor;
  bool runOnce;
  ChatMessageItemPTSD({this.chatData,this.animationController, this.callback, this.isSelectColor, this.runOnce});


  @override
  _ChatMessageItemPTSDState createState() => _ChatMessageItemPTSDState();
}

class _ChatMessageItemPTSDState extends State<ChatMessageItemPTSD> {

  Result result = Result();

  @override
  Widget build(BuildContext context) {
    return widget.animationController != null ? _animationContainer(context) : _normalContainer(context);
  }

  Widget _normalContainer(context) {
      return widget.chatData.messageType == 'RECEIVE'
            ?
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Container(child: SizedBox(width: 45.0, height: 45.0,
                   child: Image.asset('user.png', fit: BoxFit.fill))),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 8.0, right: 15.0, bottom: 8.0, left: 15.0),
                    margin: EdgeInsets.only(top: 7, left: 8, right: 8),
                    decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius:  BorderRadius.only(
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

                        Text(widget.chatData.message == 'GREEN' || widget.chatData.message == 'YELLOW' || widget.chatData.message == 'RED'?
                            '검사가 종료되었습니다.': widget.chatData.message, textScaleFactor: 0.9, style: TextStyle(color: Color(0xFF363636))),

                        Visibility(
                          visible: widget.chatData.answerType == 'none'||widget.chatData.answerType == 'input' ? false: true,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FittedBox(
                                child: Container(
                                  padding: const EdgeInsets.only(top:10.0),
                                    child: SizedBox(
                                        width: MediaQuery.of(context).size.width / 1.5 - 35.0,
                                        child: GridView.builder(
                                            shrinkWrap: true,
                                            reverse: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: widget.chatData.chatAnswersData.length,
                                            itemBuilder: (BuildContext context, int index)
                                            {
                                              return buildGridViewSelect(index);
                                            },
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisExtent:50.0, crossAxisCount: 1, crossAxisSpacing: 0.0, mainAxisSpacing: 0, childAspectRatio: 2.9)))
                                ),
                              ),
                            ],
                          ),
                        ),

                        Visibility(
                          visible:  widget.chatData.message == 'GREEN' || widget.chatData.message == 'YELLOW' || widget.chatData.message == 'RED' ? true : false,
                          child: Container(
                              padding: EdgeInsets.only(top: 10),
                              width:MediaQuery.of(context).size.width / 1.8,
                              height: 55,
                              child: Padding(padding: EdgeInsets.all(4.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(elevation: 0,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
                                        primary: mainColor),
                                    onPressed: ()
                                    {
                                      Navigator.pop(context);
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> ResultPage(calculation(widget.chatData.message))));
                                    },
                                    child: Text('결과 확인', textScaleFactor: 1.1,style: TextStyle(color: Colors.white, letterSpacing: 1.5, fontWeight: FontWeight.bold))),
                              )),
                        )

                      ],
                    ),
                  ),

                ],
              ),
            ],
          )
      )
          :
        Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment:  MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Container(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    Container(
                      padding: EdgeInsets.only(top: 8.0, right: 15.0, bottom: 8.0, left: 15.0),
                      margin: EdgeInsets.only(top: 7, left: 8, right: 8),
                      decoration: BoxDecoration(
                          color: mainColor , // Color(0xFF56CA8F1),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.zero, bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0)
                          )
                      ),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 1.6,
                          minHeight: 30
                      ),
                      child: Text(widget.chatData.message, textScaleFactor: 1.0, style:TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            )
        );
  }

  Widget _animationContainer(context) {
    return SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: widget.animationController,
            curve: Curves.fastOutSlowIn
        ),
        axisAlignment: -1.0,
        child: _normalContainer(context)
    );
  }
  // 선택지
  Widget buildGridViewSelect (int index) {
    return GestureDetector(
        onTap: () {
          ChatSelect select = ChatSelect(
              questionNo:int.parse(widget.chatData.questionNo),
              answerNo: widget.chatData.chatAnswersData[index].answerNo,
              answerMessage:widget.chatData.chatAnswersData[index].answerMessage
          );

          print('questionNo: ${widget.chatData.questionNo}');
          print('answerNo: ${widget.chatData.chatAnswersData[index].answerNo}');
          print('answerMessage: ${widget.chatData.chatAnswersData[index].answerMessage}');
          setState(() {
            if(widget.runOnce)
            {
              widget.isSelectColor[index] = true;
              widget.runOnce = false;
              widget.callback(select); // ChatPage 로 넘어가는 값
                       }
          });
        },
        child:Common.buildChatGridViewItem(widget.chatData.chatAnswersData[index].answerMessage, widget.isSelectColor[index])
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
