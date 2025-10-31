import 'package:flutter/material.dart';

class Todo {
  String title;
  bool completed;

  Todo({required this.title, this.completed = false});

  void toggleCompleted() {
    completed = !completed;
  }
}

//앱 전역에서 사용해야 하는 provider 로 공개되어 이용되어야 하는 데이터..
class TodosModel extends ChangeNotifier {
  List<Todo> todos = [];

  void addTodo(Todo todo){
    todos.add(todo);
    notifyListeners();//상태를 변경한 후에 하위 위젯에 변경사항 전파되게 하기 위해서..
  }
  void toggleTodo(Todo todo){
    final index = todos.indexOf(todo);
    todos[index].toggleCompleted();
    notifyListeners();
  }
  void deleteTodo(Todo todo){
    todos.remove(todo);
    notifyListeners();
  }
}