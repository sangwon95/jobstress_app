// id 찾기 확인버튼
import 'package:flutter/material.dart';
import 'package:jobstress_app/data/userVO.dart';
import 'package:jobstress_app/page/chat_bot_page.dart';
import 'package:jobstress_app/page/ptsd_chat_page.dart';
import 'package:jobstress_app/utils/color.dart';
import 'package:jobstress_app/utils/validators.dart';

class NextButton extends StatelessWidget {

  final String text;
  final String gender;
  final TextEditingController emailController;
  final TextEditingController ageController;
  final TextEditingController jobController;
  final VoidCallback callback;

  NextButton({this.text, this.gender, this.emailController, this.ageController, this.jobController, this.callback});

  @override
  Widget build(BuildContext context) {

    return  Container(
        padding: EdgeInsets.only(top: 0, right: 20.0, left: 20.0, bottom: 10.0),
        width: double.infinity,
        child: ElevatedButton(
            style:TextButton.styleFrom(backgroundColor: mainColor,
              padding: EdgeInsets.all(17.0),
              elevation: 1.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            ),
            onPressed: () async
            {
              CheckValidate _validate = CheckValidate();

              if(_validate.validateEmail(emailController.text, context) && _validate.validateAge(ageController.text, context) && _validate.validateJob(jobController.text, context)
                  && _validate.validateGender(gender, context)){

                UserVO userVO = UserVO(emailController.text, gender, ageController.text, jobController.text);
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChatBotPage(userVO)));

                callback();
              }

            },
            child: Text(text, textScaleFactor:1.0, style: TextStyle( color: Colors.white, letterSpacing: 1.5, fontWeight: FontWeight.bold))));
  }
}