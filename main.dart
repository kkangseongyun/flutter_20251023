import 'package:flutter/material.dart';
import 'package:flutter_lab/provider/MyInfoModel.dart';
import 'package:flutter_lab/screen/bloc/BlocMainScreen.dart';
import 'package:flutter_lab/screen/detail/DetailScreen.dart';
import 'package:flutter_lab/screen/dio/DioTestScreen.dart';
import 'package:flutter_lab/screen/event/EventScreen.dart';
import 'package:flutter_lab/screen/main/MainScreen.dart';
import 'package:flutter_lab/screen/myinfo/MyInfoScreen.dart';
import 'package:flutter_lab/screen/platform/PlatformScreen.dart';
import 'package:flutter_lab/screen/provider/ProviderMainScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyInfoModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/main',
        routes: {
          '/main': (context) => MainScreen(),
          '/event': (context) => EventScreen(),
          '/myinfo': (context) => MyInfoScreen(),
          '/dio': (context) => DioTestScreen(),
          '/provider': (context) => ProviderMainScreen(),
          '/bloc': (context) => BlocMainScreen(),
          '/platform': (context) => PlatformScreen(),
        },
        //라이팅 요청이 들어올때.. 개발자 코드가 실행되어야 하는 경우.. 조건에 따라 상이한 화면 전환이 필요하거나..
        //화면전환 전에 처리할 로직이 있거나..
        //매개변수는 어디선가 요청한 화면 전환 정보.. 이름.. 전달하는 데이터..
        onGenerateRoute: (settings){
          if(settings.name == '/detail'){
            //필요한 로직 추가하고..
            return MaterialPageRoute(
              builder: (context) => DetailScreen(),
              settings: settings,//요청시에 argument 값이 추가될 수도 있어서 그대로 붙혀줘야 된다..
            );
          }
        },
      )
    );
  }
}

