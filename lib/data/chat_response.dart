import 'package:jobstress_app/data/rest_response.dart';

import 'chat_answers.dart';

class PTSDChatResponse{
  String userIdx;
  String questionNo;
  String questionMessage;
  String answerType;
  List<ChatAnswersPTSD> chatAnswersData = [];


  PTSDChatResponse({this.userIdx, this.questionNo, this.questionMessage, this.answerType});

  factory PTSDChatResponse.fromJson(RestResponse responseBody) {
    return PTSDChatResponse(
      userIdx          : responseBody.data['userIdx'] as String ?? '-',
      questionNo       : responseBody.data['questionNo'] as String ?? '-',
      questionMessage  : responseBody.data['questionMessage'] as String ?? '-',
      answerType       : responseBody.data['answerType'] as String?? '-',
    );
  }
}