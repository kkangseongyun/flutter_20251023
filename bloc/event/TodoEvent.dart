import '../state/TodoState.dart';

//Bloc 에 상태 관리를 위해 발생시키는 이벤트..
//특별한 작성 규칙이 있지는 않다..
//이벤트를 식별만 하면 된다면.. enum 상수로..
//이벤트 발생시에 넘길 데이터가 있다면.. 클래스로..

//여러 이벤트의 공통 타입으로 사용하기 위해서..
abstract class TodosEvent {}

class AddTodoEvent extends TodosEvent{
  Todo todo;
  AddTodoEvent(this.todo);
}

class DeleteTodoEvent extends TodosEvent {
  Todo todo;
  DeleteTodoEvent(this.todo);
}

class ToggleCompletedTodoEvent extends TodosEvent {
  Todo todo;
  ToggleCompletedTodoEvent(this.todo);
}