
import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobstress_app/controller/chat_bot_controller.dart';
import 'package:jobstress_app/data/chat_bot_model.dart';
import 'package:jobstress_app/data/request_chat_data.dart';
import 'package:jobstress_app/data/userVO.dart';
import 'package:jobstress_app/utils/color.dart';
import 'package:jobstress_app/utils/common.dart';

import '../chat_bot_message_item.dart';
import '../main.dart';


/// 챗봇 화면
class ChatBotPage extends StatefulWidget {

  final UserVO userVO;

  ChatBotPage(this.userVO);

  @override
  State<ChatBotPage> createState() => ChatBotPageState();
}


class ChatBotPageState extends State<ChatBotPage> with TickerProviderStateMixin {

  /// List of ChatBot message
  final List<ChatBotMessageItem> _messageItemList = [];

  /// 키보드 포커스
  FocusNode myFocusNode = FocusNode();

  /// chat list ScrollController
  ScrollController scrollController = ScrollController();

  /// ChatBot Model Class
  ChatBotModel  sendRequestChatData;

  /// 초기 ChatDat 요청 클래스
  RequestChatData _initRequestChatData;

  /// ChatBot controller
  ChatBotController _chatBotController;

  /// Gridview item color list of input type
  List<bool> isSelectColor;

  int delayTime = 0;

  /// answerType is action
  /// if delayTime is null, default is set to 7 seconds.
  String defaultDelayTime = '7';

  /// Padding to prevent clipping under iOS
  double composerBottomPadding = 0;

  /// Default time = 1초
  int commonDelayTime = 1000;

  /// DB index
  /// 처음에는 무조건 -1 로 시작해야된다.
  String userIdx = '-1';


  var currentProgress = 0;        // 진행 갯수
  var currentProgressValue = 0.0; // 진행 게이지

  final int lastNumber = 39;      // 39개 문항
  double rateIncrease  = 0.0256;  // 증가율 39/100



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initRequestChatData = RequestChatData(
        answerMessage : '',
        answerNo      : '',
        questionNo    : 0,
        userIdx       : userIdx,
        age           : widget.userVO.age,
        email         : widget.userVO.email,
        job           : widget.userVO.job,
        sex           : widget.userVO.gender
    );

    _initChatBotController();

  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    /// 네트워크 연결 상태 확인
    //NetWorkConnectivity(context: context);

    return Scaffold(
      appBar: Common.doAppBar('직무스트레스 상담'),

      body: Stack(
        children: [
          Container(
            child: Column(
              children:
              [
                /// 채팅 리스트
                 Flexible(
                   child: ListView.builder(
                     controller: scrollController,
                     padding: EdgeInsets.fromLTRB(8, 8, 8, 40),
                     reverse: true,
                     itemBuilder: (context, index) => _messageItemList[index],
                     itemCount: _messageItemList.length,
                   ),
              ),
            ],
          ),
        ),
          SizedBox(height: 1.0),

          Opacity(
            opacity: 0.8,
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(2.0))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          SizedBox(
                              width:90,
                              child: Text('진행률 $currentProgress/$lastNumber', textScaleFactor: 0.9, style: TextStyle(fontWeight: FontWeight.bold))),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            height: 12,
                            width: MediaQuery.of(context).size.width - 110,
                            child: ClipRRect(borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(value: currentProgressValue, backgroundColor: Colors.grey,
                                  valueColor: AlwaysStoppedAnimation<Color>(mainColor)),
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
          )


        ]
      ),
    );
  }


  /// ChatBotController Class 초기화
  /// Start the ChatBot.
  void _initChatBotController()
  {
    _chatBotController = ChatBotController(
        createMessageCallback: (chatBotMessageItem) => createMessageItem(chatBotMessageItem)
    );

    Future.delayed(const Duration(milliseconds: 500),()
    {
      _chatBotController.requestChat(requestChatData: _initRequestChatData, context: context);
    });
  }


  /// 메시지 생성
  /// ChatBotController Class : Function(ChatBotData) createMessageCallback 선언
  void createMessageItem(ChatBotModel responseChatBotModel) {
    ChatBotMessageItem _chatBotMessageItem;

    /// 챗봇 선택지 생성
    if (responseChatBotModel.messageUIType == 'SELECT') {
      List<bool> isSelectColorList = [];

      for (int i = 0; i < responseChatBotModel.chatAnswersList.length; i++) {
        isSelectColorList.add(false);
      }

      _chatBotMessageItem = ChatBotMessageItem(
          chatBotModel: responseChatBotModel,
          runOnce: true,
          isSelectColor: isSelectColorList,
          animationController: AnimationController(
              duration: Duration(milliseconds: commonDelayTime), vsync: this),
          callback: (requestChatData) => getAnswer(requestChatData));
    }

    /// 챗봇 질문 생성
    /// messageUIType:'RECEIVE'
    else {

      /// Message Item 생성
      /// answerType [input, none] 동일하게 생성
      _chatBotMessageItem = ChatBotMessageItem(
          chatBotModel: responseChatBotModel,
          runOnce: true,
          animationController: AnimationController(
              duration: Duration(milliseconds: commonDelayTime), vsync: this));

      /// 검사 진행률 표시
      currentProgress = int.parse(responseChatBotModel.questionNo);

      if(currentProgress == lastNumber)
      {
        currentProgressValue = 1;
      }

      if(responseChatBotModel.answerType != 'select'){
        if(!(responseChatBotModel.questionMessage == 'GREEN' || responseChatBotModel.questionMessage == 'YELLOW' || responseChatBotModel.questionMessage == 'RED')){
          getAnswer(RequestChatData(
              answerMessage : '',
              answerNo      : '',
              questionNo    : int.parse(responseChatBotModel.questionNo),
              userIdx       : responseChatBotModel.userIdx,
              age           : widget.userVO.age,
              email         : widget.userVO.email,
              job           : widget.userVO.job,
              sex           : widget.userVO.gender
          ));
        }
      }
    }

    /// messageUiType 에 따른 메시지 생성 후
    /// 채팅 리스트 갱신
    setState(() {
      _messageItemList.insert(0, _chatBotMessageItem);

      // 리스트 갱신 후 List 최 하단으로 이동
      scrollController.jumpTo(scrollController.position.minScrollExtent);
    });
    _chatBotMessageItem.animationController.forward();
  }


  /// 응답한 데이터 가져오기
  /// 다음 질문 호출
  void getAnswer(RequestChatData requestChatData)
  {
    currentProgressValue += rateIncrease;

    _chatBotController.requestChat(requestChatData: RequestChatData(
        answerMessage : requestChatData.answerMessage,
        answerNo      : requestChatData.answerNo,
        questionNo    : requestChatData.questionNo,
        userIdx       : requestChatData.userIdx,
        age           : widget.userVO.age,
        email         : widget.userVO.email,
        job           : widget.userVO.job,
        sex           : widget.userVO.gender
    ), context: context);
  }
}




