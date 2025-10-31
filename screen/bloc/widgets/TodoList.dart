import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/state/TodoState.dart';
import '../../../bloc/event/TodoEvent.dart';
import '../../../bloc/TodosBloc.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;

  TodoListItem({required this.todo});

  @override
  Widget build(BuildContext context) {
   //Bloc 객체 획득..
    TodosBloc todosBloc = BlocProvider.of<TodosBloc>(context);
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, data){
        return ListTile(
          leading: Checkbox(
              value: todo.completed,
              onChanged: (bool? checked){
                //bloc 에 이벤트 발생시켜서 상태가 유지되게 한다..
                todosBloc.add(ToggleCompletedTodoEvent(todo));
              }
          ),
          title: Text(todo.title),
          trailing: IconButton(
              onPressed: (){
                //bloc 에 이벤트 발생..
                todosBloc.add(DeleteTodoEvent(todo));
              },
              icon: Icon(Icons.delete, color: Colors.red,)
          ),
        );
      },
    );

  }
}

class TodoList extends StatelessWidget {
  final List<Todo> todos;

  TodoList({required this.todos});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getChildrenTodos(),
    );
  }

  List<Widget> getChildrenTodos() {
    return todos.map((todo) => TodoListItem(todo: todo)).toList();
  }

}
