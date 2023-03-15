import 'package:flutter/material.dart';
import 'package:jobstress_app/data/gender.dart';
import 'package:jobstress_app/utils/button.dart';
import 'package:jobstress_app/utils/color.dart';
import 'package:jobstress_app/utils/common.dart';
import 'package:jobstress_app/utils/edit.dart';

class SignPage extends StatefulWidget {

  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {

  final emailController = TextEditingController();
  final ageController   = TextEditingController();
  final jobController   = TextEditingController();

  final _gridViewGender = GridViewGender(); // 성별

  String gender; // 성별
  String genderName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: mainColor,
          centerTitle: true,
          elevation: 0.0,
        ),

        body: GestureDetector(
          onTap: ()
          {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Container(
                    decoration: BoxDecoration(
                        color:mainColor,
                        borderRadius: BorderRadius.only(bottomLeft: const Radius.circular(30.0), bottomRight: const Radius.circular(30.0))),
                    constraints: BoxConstraints.expand(height: 200),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Common.doLogo(context:context, height:300),
                        ])
                ),

                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: InputEdit(controller: emailController , iconData: Icons.email_outlined, headText: '이메일', hint: '이메일을 입력해주세요.', type: 'email')),

                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                  child: InputEdit(controller: ageController , iconData: Icons.account_circle_outlined, headText: '나이', hint: '나이를 입력해주세요.', type: 'number')),

                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                  child: InputEdit(controller: jobController , iconData: Icons.work_outline, headText: '직업', hint: '예) 무직, 학생, 공무원 등등', type: 'job')),

                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top:20),
                    child: Text('성별', textScaleFactor:1.0, style: TextStyle(fontWeight: FontWeight.bold))),

                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _gridViewGender.cardNames.length,
                              itemBuilder: (BuildContext context, int index) {
                                return buildGridViewGender(index);
                              },
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)))),
                ),

                NextButton(
                    text: '검사진행',
                    emailController : emailController,
                    ageController: ageController,
                    jobController: jobController,
                    gender: gender,
                    callback: ()=>viewReset()
                )
              ],
            ),
          ),
        ));
  }

  // 성별
  Widget buildGridViewGender(int index) {
    //String name = _gridViewGender.cardNames[index];
    if(_gridViewGender.cardNames[index] == 'M')
      genderName = '남자';
    else
      genderName = '여자';

    return GestureDetector(
        onTap: () {
          setState(() {
            FocusScope.of(context).unfocus();

            if (_gridViewGender.isGender[index]) {
              _gridViewGender.isGender[index] = false;
              gender = '';
            } else  {
              for(int i=0 ; i<_gridViewGender.isGender.length ; i++){
                if(index != i){
                  _gridViewGender.isGender[i] = false;
                }
              }
              _gridViewGender.isGender[index] = true;
              gender = _gridViewGender.cardNames[index];
            }

          }
          );},
        child: Common.buildGridViewItem2(genderName, _gridViewGender.isGender[index])
    );
  }

  void viewReset(){
    setState(() {
      ageController.text = '';
      jobController.text = '';
      emailController.text = '';
      _gridViewGender.isGender[0] = false;
      _gridViewGender.isGender[1] = false;
      gender = '';
    });

  }
}
