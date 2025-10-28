import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  List<Widget> widgets = [
    //case1 - 타입이 다른 StatefulWidget 이 여러개..
    //==>위젯의 타입을 우선으로.. State객체 매핑.. 타입만 다르다면 문제가 없다..
    //==>key 주지 않아도 된다..
    // MyItemWidgetA(Colors.red),
    // MyItemWidgetB(Colors.blue),

    //case2 - 동일 타입의 위젯이 여러개... key를 사용하지 않은 경우..
    //위젯타입으로 식별이 되지 않아서 순서로 매핑한다.. 구조가 변경된 경우(순서, 갯수) 이상반응 가능성 있다..
    // MyItemWidgetA(Colors.red),
    // MyItemWidgetA(Colors.blue),

    //case3 - 동일 타입의 위젯이 여러개... key를 사용
    //키가 설정되어 있다면 키를 우선해서.. 위젯과 매핑..
    MyItemWidgetA(Colors.red, key: UniqueKey(),),
    MyItemWidgetA(Colors.blue, key: UniqueKey(),),
  ];

  onChange(){
    setState(() {
      widgets.insert(1, widgets.removeAt(0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('key test'),),
        body: Column(
          children: [
            Row(children: widgets,),
            ElevatedButton(onPressed: onChange, child: Text('toggle'),),
          ],
        ),
      ),
    );
  }
}

class MyItemWidgetA extends StatefulWidget{
  Color color;
  MyItemWidgetA(this.color, {Key? key}): super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MyItemStateA(color);
  }
}
class MyItemStateA extends State<MyItemWidgetA> {
  Color color;
  MyItemStateA(this.color);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: color,
        width: 100,
        height: 150,
      )
    );
  }
}

class MyItemWidgetB extends StatefulWidget{
  Color color;
  MyItemWidgetB(this.color, {Key? key}): super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MyItemStateB(color);
  }
}
class MyItemStateB extends State<MyItemWidgetB> {
  Color color;
  MyItemStateB(this.color);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          color: color,
          width: 100,
          height: 150,
        )
    );
  }
}