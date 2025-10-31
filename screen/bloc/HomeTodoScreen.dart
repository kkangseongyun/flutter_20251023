import 'package:flutter/material.dart';



import 'AddTodoScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/TodosBloc.dart';
import 'widgets/TodoList.dart';
import '../../bloc/state/TodoState.dart';

class TabScreen extends StatelessWidget {

  List<Todo> todos;

  TabScreen(this.todos);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TodoList(
        todos: this.todos,
      ),
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
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Todos-Bloc'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => AddTodoScreen(),
              ),);
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
      //Bloc 의 데이터로 화면 구성..
      body: BlocBuilder<TodosBloc, TodosState>(
        //매개변수로 bloc 의 상태 전달..
        builder: (context, state){
          return TabBarView(
            controller: controller,
            children: [
              TabScreen(state.todos),
              TabScreen(state.todos.where((todo) => !todo.completed).toList()),
              TabScreen(state.todos.where((todo) => todo.completed).toList())
            ],
          );
        },
      )
      
    );


  }
}
