import 'package:flutter/material.dart';
import 'package:jobstress_app/page/chat_bot_page.dart';
import 'package:jobstress_app/utils/color.dart';
import 'package:jobstress_app/utils/logging.dart';

import 'data/userVO.dart';
import 'page/chat_page.dart';
import 'page/sign_page.dart';

/// Custom Log
final mLog = logger;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized(); //플랫폼 채널의 위젯 바인딩을 보장해야한다.
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final themeData = ThemeData();

  @override
  Widget build(BuildContext context) {
    UserVO userVO = UserVO('tkds@naver.com', '남', '2', '개발자');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:Theme.of(context).copyWith(
          colorScheme: themeData.colorScheme.copyWith(primary: mainColor),
          primaryTextTheme: themeData.textTheme.apply(fontFamily: 'nanum_square')
      ),

      initialRoute: '/',
      routes: {
        '/' : (context) =>  SignPage(),
      },
    );
  }
}

