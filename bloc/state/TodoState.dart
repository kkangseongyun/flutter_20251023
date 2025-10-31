//Bloc 에 의해 관리, 유지되는 상태 데이터..
//특별한 작성 규칙이 있지는 않다..
class Todo {
  String title;
  bool completed;
  Todo({required this.title, this.completed = false});
  void toggleCompleted(){
    completed = !completed;
  }
}

class TodosState {
  List<Todo> todos;
  TodosState(this.todos);
}