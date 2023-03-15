import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jobstress_app/data/chat_answers.dart';
import 'package:jobstress_app/data/chat_bot_model.dart';
import 'package:jobstress_app/data/chat_response.dart';
import 'package:jobstress_app/data/rest_response.dart';
import 'package:jobstress_app/utils/etc.dart';

const API_PREFIX = 'http://106.251.70.71:60004/ws';

Client client = Client();

class Client {
  int pageCnt;

  Dio _createDio() {
    Dio dio = Dio();
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;

    dio.options.headers = {
      'Content-Type': 'application/json',
    };

    return dio;
  }


  //  PTSD chat data 요청
  Future<PTSDChatResponse> dioPTSDChat(Map<String, dynamic> data) async {

    List<ChatAnswersPTSD> chatAnswersData = [];
    PTSDChatResponse chatResponse = PTSDChatResponse();

    try {
      print('**** Call : $API_PREFIX/private/ptsd/test ****');
      Response response = await Dio().post('$API_PREFIX/private/ptsd/test', data: data);

      if (response.statusCode == 200) {
        print('response.statusCode : '+response.data['status']['message']);

        if (response.data['status']['code'] == '200') {
          print('userIdx : '+response.data['data']['userIdx']);

          chatAnswersData = ChatAnswersPTSD.parse(RestResponse.fromJson(response.data));  // answers 파싱값
          chatResponse = PTSDChatResponse.fromJson(RestResponse.fromJson(response.data)); // data 파싱값
          chatResponse.chatAnswersData = chatAnswersData;

          return chatResponse;
        }

      } else {
        print('checkSign Response statusCode ::' + response.statusCode.toString());
        print('checkSign Response statusMessage ::' + response.statusMessage.toString());
      }
    } on DioError catch (e) {
      print(e.toString());
      throw Exception('서버 연결 오류');
    } catch (e) {
      print(e.toString());
    }

    return chatResponse;
  }

  /// chat bot dio
  Future<ChatBotModel> dioChatBot(Map<String, dynamic> data) async {

    Etc.getValuesFromMap(data);
    List<ChatAnswers> chatAnswersList = [];
    ChatBotModel chatBotModel;

    try {
      print('**** Call : $API_PREFIX/private/ptsd/test ****');
      Response response = await Dio().post('$API_PREFIX/private/ptsd/test', data: data);

      if (response.statusCode == 200) {
        print('response.statusCode : '+response.data['status']['message']);

        if (response.data['status']['code'] == '200') {
          print('userIdx : '+response.data['data']['userIdx']);

          chatAnswersList = ChatAnswers.parse(RestResponse.fromJson(response.data));  // answers 파싱값
          chatBotModel = ChatBotModel.fromJson(RestResponse.fromJson(response.data)); // data 파싱값
          chatBotModel.chatAnswersList = chatAnswersList;

          return chatBotModel;
        }

      } else {
        print('checkSign Response statusCode ::' + response.statusCode.toString());
        print('checkSign Response statusMessage ::' + response.statusMessage.toString());
      }
    } on DioError catch (e) {
      print(e.toString());
      throw Exception('서버 연결 오류');
    } catch (e) {
      print(e.toString());
    }

    return chatBotModel;
  }

}