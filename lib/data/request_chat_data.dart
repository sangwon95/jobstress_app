
import 'package:jobstress_app/data/userVO.dart';

/// [ChatBotController.class]-[requestChat method] Data Class
/// 질문 및 [nextExcelProcession] 데이터를 받기위한 body data
class RequestChatData {

  String userIdx;
  int questionNo;
  String answerNo;
  String answerMessage;
  String age;
  String sex;
  String job;
  String email;

  RequestChatData({
    this.userIdx,
    this.questionNo,
    this.answerNo,
    this.answerMessage,
    this.age,
    this.sex,
    this.job,
    this.email
  });


  @override
  String toString() {
    return 'RequestChatData{userIdx: $userIdx, questionNo: $questionNo, answerNo: $answerNo, answerMessage: $answerMessage, age: $age, sex: $sex, job: $job, email: $email}';
  }

  Map<String, dynamic> toMap(){
    Map<String,dynamic> toMap ={
      'userIdx'       : userIdx,
      'questionNo'    : questionNo,
      'answerNo'      : answerNo,
      "answerMessage" : answerMessage,
      "age"           : age,
      "job"           : job,
      "sex"           : sex,
      "email"         : email,
    };
    return toMap;
  }

}