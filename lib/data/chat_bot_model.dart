import 'package:jobstress_app/data/rest_response.dart';
import 'chat_answers.dart';

class ChatBotModel{
  String userIdx;
  String questionNo;
  String questionMessage;
  String answerType;
  List<ChatAnswers> chatAnswersList = [];
  String messageUIType;// [RECEIVE], [SELECT], [SEND] 3가지 유형으로 나뉜다.

  ChatBotModel({this.userIdx, this.questionNo, this.questionMessage, this.answerType, this.messageUIType, this.chatAnswersList});


  @override
  String toString() {
    return 'ChatBotModel{userIdx: $userIdx, questionNo: $questionNo, questionMessage: $questionMessage, answerType: $answerType, chatAnswersList: $chatAnswersList, messageUIType: $messageUIType}';
  }

  factory ChatBotModel.fromJson(RestResponse responseBody) {
    return ChatBotModel(
      userIdx          : responseBody.data['userIdx'] as String ?? '-',
      questionNo       : responseBody.data['questionNo'] as String ?? '-',
      questionMessage  : responseBody.data['questionMessage'] as String ?? '-',
      answerType       : responseBody.data['answerType'] as String?? '-',
    );
  }
}