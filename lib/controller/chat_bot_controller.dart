
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:jobstress_app/data/chat_bot_model.dart';
import 'package:jobstress_app/data/request_chat_data.dart';
import 'package:jobstress_app/utils/dialog.dart';
import 'package:jobstress_app/utils/dio_client.dart';

import '../main.dart';


/// 챗봇의 타입에 따른 ChatItem 생성및 분기 클래스
class ChatBotController{

  final Function(ChatBotModel) createMessageCallback;
  ChatBotController({this.createMessageCallback});

  /// 서버로부터 받은 chatBot data
  ChatBotModel responseChatBotModel;

  /// 다음 챗데이터 딜레이 1초
  int nextDelayTime = 1;


  /// 서버에 데이터 전송 및 수신
  void requestChat({RequestChatData requestChatData, BuildContext context}) async
  {
    try{
      responseChatBotModel = await client.dioChatBot(requestChatData.toMap());
      responseChatBotModel.toString();

    Future.delayed(Duration(seconds: nextDelayTime), (){
      if (responseChatBotModel.answerType == 'none') {
        _createNoneMessage();
      }
      else if(responseChatBotModel.answerType == 'select') {
        _createSelectionMessage();
      }
      else{
        /// when answerType of input
        _createInputMessage();
      }
    });

    }

    /// 챗봇 대화 요청 Error 처리
    catch (error) {
      String text;
      print('catch : $error');

      if(error.toString().contains('response'))
      {

        text = '현재 서버를 찾을 수 없습니다. 다시 시도바랍니다.';
      }
      else if(error.toString().contains('connect'))
      {

        text = '서버와 연결이 불안하여 응답을 받지 못했습니다.';
      }
      else if(error.toString().contains('receive'))
      {

        text = '서버가 불안정하여 응답을 받지 못했습니다.';
      }
      else{

        text = '알 수 없는 서버 오류 입니다.';
      }

      // /// 에러 발생 시  다이얼로그를 띄워준다.
      // CustomDialog.showDioDialog(
      //     '챗봇오류!',
      //     text,
      //     context,
      //     onPositive: () {
      //       Navigator.pop(context);
      //       Future.delayed(Duration(seconds: 1), (){
      //         requestChat(requestChatData: requestChatData, context: context);
      //       });
      //     },
      //     onNegative: (){
      //       Navigator.pop(context); // Dialog pop
      //
      //       if(!ModalRoute.of(context)!.isFirst){
      //         // Navigator stack 이 존재할경우
      //         Navigator.pop(context);
      //       }
      //       else{
      //         // Navigator stack 이 없을 경우 앱 종료
      //         if (Platform.isIOS) {
      //           exit(0);
      //         } else {
      //           SystemNavigator.pop();
      //         }
      //       }
      //     });
    }
  }


  /// None 의 형태 메시지를 생성한다.
  void _createNoneMessage() {
    mLog.i(responseChatBotModel.toString());

    responseChatBotModel.messageUIType = 'RECEIVE';

    createMessageCallback(responseChatBotModel); // none 형식의 메시지 생성
  }


  /// Conditional 의 형태 메시지를 생성한다.
  void _createConditionalMessage() {
    mLog.i(responseChatBotModel.toString());

    createMessageCallback(responseChatBotModel); // none 형식의 메시지 생성
  }

  /// Selection 의 형태 메시지를 생성한다.
  void _createSelectionMessage() {
    mLog.i(responseChatBotModel.toString());

    /// select 질문생성
    responseChatBotModel.messageUIType = 'RECEIVE';
    createMessageCallback(responseChatBotModel);

    /// 2초 딜레이 후 선택지를 생성한다.
    Future.delayed(const Duration(milliseconds: 1300),()
    {
      ChatBotModel selectionChatBotModel = ChatBotModel(
        userIdx          : responseChatBotModel.userIdx,
        questionNo       : responseChatBotModel.questionNo,
        questionMessage  : responseChatBotModel.questionMessage,
        answerType       : responseChatBotModel.answerType,
        chatAnswersList  : responseChatBotModel.chatAnswersList,
        messageUIType    : 'SELECT',
      );

      createMessageCallback(selectionChatBotModel);
    });
  }


  /// Input 형태의 메시지를 생성한다.
  void _createInputMessage(){
    mLog.i(responseChatBotModel.toString());

    responseChatBotModel.messageUIType = 'RECEIVE';

    createMessageCallback(responseChatBotModel); // none 형식의 메시지 생성
  }
}