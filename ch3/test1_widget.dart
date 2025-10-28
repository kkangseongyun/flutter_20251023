//flutter sdk 에서 제공되는 모든 위젯 클래스...
import 'package:flutter/material.dart';

void main() {
  //매개변수의 위젯 객체를 화면에 출력시키면서 앱 실행시키는 함수..
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  //이 위젯의 화면을 구성하기 위해서 자동 호출..
  //이 함수에서 리턴시키는 위젯이 이 클래스 위젯의 화면이다..
    @override
  Widget build(BuildContext context) {
      //필수는 아니지만.. 위젯 트리의 최 상단을 보통 MaterialApp 으로 구성..
      //앱의 테마설정.. 앱의 라우팅(화면전환)처리..
    return MaterialApp(
      //필수는 아니지만.. 전형적인 화면의 기본 구조(AppBar, NavigationItem, Drawer 등)
      home: Scaffold(
        appBar: AppBar(
          title: Text('Widget Test'),
        ),
        body: Center(
          child: Column(
            children: [
              MyStatelessWidget(),
              MyStatefulWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {

  //stateless 위젯도 얼마든지.. 변수를 가질 수 있고.. 적절한 시점에 그 변수 값을 변경시킬 수 있다..
  //stateless 임으로.. 자체적으로 화면을 갱신(re-rendering)할 수 없다..
  bool favorited = false;
  int favoritedCount = 10;

  //이벤트 콜백함수..
  void toggleFavorite(){
    print('stateless.... toggleFavorited...');
    if(favorited){
      favoritedCount -= 1;
      favorited = false;
    }else {
      favoritedCount += 1;
      favorited = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("stateless... build...");
    return Row(
      children: [
        IconButton(
            onPressed: toggleFavorite,
            icon: favorited ? Icon(Icons.star) : Icon(Icons.star_border),
            color: Colors.red,
        ),
        Container(//화면이 출력되는 영역 지정..
          child: Text('$favoritedCount'),
        )
      ],
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<MyStatefulWidget> {
  bool favorited = false;
  int favoritedCount = 10;

  //이벤트 콜백함수..
  void toggleFavorite(){
    print('stateful.... toggleFavorited...');
    //상태를 가지는 위젯이다.. 상태 변경에 따른 화면 갱신이 가능하다..
    //화면 갱신은 setState() 에 의해... build 함수를 다시 호출하게 된다..
    //setState() 함수의 매개변수는 개발자 함수이다..
    //개발자 함수가 먼저 호출이되고.. 실행이 끝나면.. build 함수 호출...
    //결국 개발자 함수에서.. 상태값 변경..
    setState(() {
      if(favorited){
        favoritedCount -= 1;
        favorited = false;
      }else {
        favoritedCount += 1;
        favorited = true;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    print("stateful... build...");
    return Row(
      children: [
        IconButton(
          onPressed: toggleFavorite,
          icon: favorited ? Icon(Icons.star) : Icon(Icons.star_border),
          color: Colors.red,
        ),
        Container(//화면이 출력되는 영역 지정..
          child: Text('$favoritedCount'),
        )
      ],
    );
  }
}