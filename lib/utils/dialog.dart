import 'package:flutter/material.dart';
import '../utils/color.dart';

class CustomDialog{

  static showMyDialog({String title, String text, BuildContext mainContext, bool isCancelBtn}) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, textScaleFactor: 0.85, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(10, 12, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 190,
                      child: Text(text, textAlign: TextAlign.center, textScaleFactor: 0.85)),
                ],
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            actionsPadding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),

            actions: [
              Visibility(
                visible: isCancelBtn,
                child: Container(
                  width: 120,
                  height: 40,
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          elevation: 3.0,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                             // side: BorderSide(width: 1.0, color: Colors.grey.shade100),
                              borderRadius: BorderRadius.circular(5.0))),
                      onPressed: ()
                      {
                        Navigator.pop(context);
                      },
                      child: Text('취소', textScaleFactor: 1.0, style: TextStyle(color: Colors.grey.shade600))
                  ),
                ),
              ),

              Container(
                height: 40,
                width: isCancelBtn ? 120 : 240,
                margin: EdgeInsets.only(bottom: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 5.0,
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.0, color: mainColor),
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: ()
                    {
                      Navigator.pop(context);
                    },
                    child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
                ),
              ),

            ],
          );
        });
  }

  /// 네트워크 연결 상태 다이얼로그
  static showNetworkDialog(String title, String text, BuildContext mainContext, Function onPressed) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, textScaleFactor: 0.85, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 190,
                      child: Text(text, textAlign: TextAlign.center, textScaleFactor: 0.85)),
                ],
              ),
            ),
            contentPadding:EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            actions: <Widget>[
              Container(
                height: 40,
                width:  240,
                margin: EdgeInsets.only(bottom: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 5.0,
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.0, color: mainColor),
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: ()
                    {
                      onPressed();
                    },
                    child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
                ),
              ),

            ],
          );
        });
  }

  /// 다이얼 로그
  static showActionDialog(String title, String text, BuildContext mainContext) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, textScaleFactor: 0.85, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 190,
                      child: Text(text, textAlign: TextAlign.center, textScaleFactor: 0.85)),
                ],
              ),
            ),
            contentPadding:EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            actions: [
              Container(
                width: 120,
                height: 40,
                margin: EdgeInsets.only(bottom: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 3.0,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
                    onPressed: ()
                    {
                      Navigator.pop(context);
                    },
                    child: Text('취소', textScaleFactor: 1.0, style: TextStyle(color: Colors.grey.shade600))
                ),
              ),

              Container(
                height: 40,
                width: 120,
                margin: EdgeInsets.only(bottom: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 5.0,
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.0, color: mainColor),
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: () async
                    {

                    },
                    child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
                ),
              ),

            ],
          );
        });
  }


  /// 네트워크 연결 상태 다이얼로그
  // static showDioDialog(String title, String text, BuildContext mainContext,
  //     { Function onPositive,  Function onNegative}) {
  //   return showDialog(
  //       context: mainContext,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  //           title: Center(
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text(title, textScaleFactor: 0.85, style: TextStyle(fontWeight: FontWeight.bold)),
  //               ],
  //             ),
  //           ),
  //           content: Padding(
  //             padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Container(
  //                     width: 190,
  //                     child: Text(text, textAlign: TextAlign.center, textScaleFactor: 0.85)),
  //               ],
  //             ),
  //           ),
  //           contentPadding:EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
  //           actions: <Widget>[
  //
  //
  //             Container(
  //               width: 120,
  //               height: 40,
  //               margin: EdgeInsets.only(bottom: 10),
  //               child: TextButton(
  //                   style: TextButton.styleFrom(
  //                       elevation: 3.0,
  //                       backgroundColor: Colors.white,
  //                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
  //                   onPressed: () => onNegative(),
  //                   child: Text('나가기', textScaleFactor: 1.0, style: TextStyle(color: Colors.grey.shade600))
  //               ),
  //             ),
  //
  //             Container(
  //               height: 40,
  //               width:  120,
  //               margin: EdgeInsets.only(bottom: 10),
  //               child: TextButton(
  //                   style: TextButton.styleFrom(
  //                       elevation: 5.0,
  //                       backgroundColor: mainColor,
  //                       shape: RoundedRectangleBorder(
  //                           side: BorderSide(width: 1.0, color: mainColor),
  //                           borderRadius: BorderRadius.circular(5.0))),
  //                   onPressed: () => onPositive(),
  //                   child: Text('재시도', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
  //               ),
  //             ),
  //
  //           ],
  //         );
  //       });
  // }
}