import 'chat_answers.dart';

class ChatDataPTSD {
  String questionNo;
  String message;
  String answerType;
  String messageType;
  String answerMessage;
  List<ChatAnswersPTSD> chatAnswersData = [];

  ChatDataPTSD(
      {this.questionNo,
        this.message,
        this.answerType,
        this.messageType,
        this.chatAnswersData,
        this.answerMessage});
}