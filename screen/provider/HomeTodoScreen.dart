import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/TodosModel.dart';
import './widgets/TodoList.dart';
import 'AddTodoScreen.dart';

class TabScreen extends StatelessWidget {

  List<Todo> todos;
  TabScreen(this.todos);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TodoList(this.todos ),
    );
  }
}


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);//animation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Todos'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTodoScreen(),
                  ),
                );
              },
            ),
          ],
          bottom: TabBar(
            controller: controller,
            tabs: <Widget>[
              Tab(text: 'All'),
              Tab(text: 'Active'),
              Tab(text: 'Complete'),
            ],
          ),
        ),
      //provider 데이터를 획득하기 위한 위젯...
      body: Consumer<TodosModel>(
        //builder의 함수가 자동 호출되면서 두번째 매개변수에 제네릭 타입으로 명시된 데이터 전달..
        builder: (context, model, child){
          //TabBar - 탭 버튼..
          //TabBarView - 탭 버튼 클릭시 나와야 하는 탭 화면..
          //탭 버튼 클릭시 나와야 하는 화면을 이벤트 처리해서 제어하지 않고.. 두 위젯이 동일 controller 를 이용하면..
          //controller에 의해 자동으로 제어된다..
          return TabBarView(
            controller: controller,
            children: [
              TabScreen(model.todos),
              TabScreen(model.todos.where((todo) => !todo.completed).toList()),
              TabScreen(model.todos.where((todo) => todo.completed).toList())
            ],
          );
        },
      ),
    );
  }
}