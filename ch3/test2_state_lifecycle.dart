import 'package:flutter/material.dart';
//상위 상태 데이터를 하위에 쉽게 전파시키기 위해서..
import 'package:provider/provider.dart';

main(){
  runApp(ParentWidget());
}

//화면 단위 위젯을 stateful 로 만드는 것은 바람직하지 않다.. 너무 많은 위젯이 다시 생성될 수 있어서 성능에 부담스럽다..
//단지 우리는 상위 위젯의 상태 변경시에.. 하위 위젯의 상태 라이프사이클 테스트 때문에...
class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ParentState();
  }
}

class ParentState extends State<ParentWidget> {
  int counter = 0;//상위에서 유지, 관리하는 상태... 하위에 전파되어야 하는 상태..

  void increment(){
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Lifecycle Test'),),
        body: Provider.value(
          value: counter,//하위에 전파되어야 하는 데이터 명시..
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('I am Parent Widget : $counter'),
                ElevatedButton(
                    onPressed: increment,
                    child: Text('increment'),
                ),
                ChildWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChildWidget extends StatefulWidget {
  ChildWidget(){
    print('ChildWidget constructor...');
  }
  @override
  State<StatefulWidget> createState() {
    return ChildState();
  }
}

//WidgetsBindingObserver - 앱의 라이프사이클 확인위해..
class ChildState extends State<ChildWidget> with WidgetsBindingObserver{
  int counter = 0;//상위의 상태 데이터가 저장..

  ChildState(){
    print('ChildState constructor...');
  }

  //상태 객체 생성되면서.. 데이터 초기화.. 이벤트 등록..
  @override
  void initState() {
    super.initState();
    print('ChildState initState...');
    //앱의 라이프사이클 변경 이벤트 등록..
    WidgetsBinding.instance.addObserver(this);//이벤트 콜백함수 현재의 클래스에 있다..
  }
  //상태 객체 소멸될때 최후에 한번.. 이벤트 등록 해제용도...
  void dispose(){
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  //initState 호출후 바로 호출... 그 후에는.. 상위 상태 값 변경될때마다..
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('ChildState didChangeDependencies...');
    //상위 데이터 획득..
    counter = Provider.of<int>(context);
  }
  @override
  Widget build(BuildContext context) {
    print('ChildState build...');
    return Text('I am ChildWidget : $counter');
  }
  //앱 라이프사이클 변경 이벤트 콜백 함수..
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state){
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
        print('app resume...');
        break;
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        print('app hidden...');
        break;
    }
  }
}
//최초로 화면이 출력되는 순간...
// I/flutter (14638): ChildWidget constructor...
// I/flutter (14638): ChildState constructor...
// I/flutter (14638): ChildState initState...
// I/flutter (14638): ChildState didChangeDependencies...
// I/flutter (14638): ChildState build...

//상위 위젯의 상태 값 변경 순간...
// StatefulWidget이다.. 매변 생성된다.. 위젯은 불변이다..
// State가 메모리에 지속되는 것이지,  stateless, stateful 위젯 모두 화면 갱신시 매번 다시 생성..
//I/flutter (14638): ChildWidget constructor...
// I/flutter (14638): ChildState didChangeDependencies...
// I/flutter (14638): ChildState build...


















