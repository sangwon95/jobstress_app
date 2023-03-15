import 'package:jobstress_app/data/rest_response.dart';

class ChatAnswers{
  String answerNo;
  String answerMessage;

  ChatAnswers({this.answerNo, this.answerMessage});

  factory ChatAnswers.fromJson(Map<String, dynamic> json) {
    return ChatAnswers(
      answerNo      : json['answerNo'] as String ?? '-',
      answerMessage : json['answerMessage'] as String ?? '-',
    );
  }

  static List<ChatAnswers> parse(RestResponse responseBody) {
    return responseBody.answers.map<ChatAnswers>((json) => ChatAnswers.fromJson(json)).toList();
  }
}

class ChatAnswersPTSD{
  String answerNo;
  String answerMessage;

  ChatAnswersPTSD({this.answerNo, this.answerMessage});

  factory ChatAnswersPTSD.fromJson(Map<String, dynamic> json) {
    return ChatAnswersPTSD(
      answerNo      : json['answerNo'] as String ?? '-',
      answerMessage : json['answerMessage'] as String ?? '-',
    );
  }

  static List<ChatAnswersPTSD> parse(RestResponse responseBody) {
    return responseBody.answers.map<ChatAnswersPTSD>((json) => ChatAnswersPTSD.fromJson(json)).toList();
  }
}
