import 'package:flutter/material.dart';
import 'package:jobstress_app/utils/dialog.dart';

import 'etc.dart';

class CheckValidate{
  //나이
  bool validateAge(String value, BuildContext context){
    if(value.isEmpty){
      CustomDialog.showMyDialog(title: '나이 작성!', text: '나이 입력란이 비어 있습니다.', mainContext: context, isCancelBtn: false);
      return false;
    }
    else {
      if(int.parse(value) > 150){
        CustomDialog.showMyDialog(title: '나이 오류!', text: '나이를 정상적으로 작성 바랍니다.', mainContext: context, isCancelBtn: false);
        return false;
      }
      else{
        return true;
      }
    }
  }
  // 직업
  bool validateJob(String value, BuildContext context){
    if(value.isEmpty){
      CustomDialog.showMyDialog(title: '직업 작성!', text: '직업 작성란이 비어 있습니다.', mainContext: context, isCancelBtn: false);
      return false;
    }
    else {
        return true;
      }
    }

  // 성별
  bool validateGender(String value, BuildContext context){
    if(value == '' || value == null){
      CustomDialog.showMyDialog(title: '성별 선택!', text: '성별을 선택해주세요.', mainContext: context, isCancelBtn: false);
      return false;
    }
    else {
     return true;
    }
  }

  // 이메일
  bool validateEmail(String value, BuildContext context){
    if(value.isEmpty)
    {
      CustomDialog.showMyDialog(title: '이메일 작성!', text: '이메일 작성란이 비어 있습니다.', mainContext: context, isCancelBtn: false);
      return false;
    }
    else {
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);
      if(!regExp.hasMatch(value))
      {
        CustomDialog.showMyDialog(title: '이메일 형식!', text: '잘못된 이메일 형식입니다.', mainContext: context, isCancelBtn: false);
        return false;
      }else{
        return true;
      }
    }
  }

  bool validatePassword(String value, BuildContext context){
    if(value.isEmpty){
      Etc.showSnackBar('비밀번호를 입력하세요.', context);
      return true;
    }else {
     // Pattern pattern = r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$';
      //== ex7, 영문(소,대문자) + 숫자 + 특수문자 + 8~20자 + (영문소, 영문대, 숫자, 특수문자 최소 1글자 이상) ==//
      String pattern = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\\W).{8,15}";
      RegExp regExp = new RegExp(pattern);
      if(!regExp.hasMatch(value)){
        Etc.showSnackBar('특수,대소문자,숫자 포함 8자~15자로 입력하세요.', context);
        return true;
      }else{
        return false;
      }
    }
  }

}