import 'package:bloc/bloc.dart';
import 'package:flutter_lab/bloc/event/TodoEvent.dart';
import 'package:flutter_lab/bloc/state/TodoState.dart';

//제네릭 타입 : 이벤트 타입 - 상태 타입
class TodosBloc extends Bloc<TodosEvent, TodosState>{
  //상위 생성자 호출하면서.. 매개변수로 상태 초기값 명시..
  TodosBloc(): super(TodosState([])){
    //이벤트 등록.. 이런 타입의 이벤트가 발생했다면..
    //매개변수, event - 발생한 이벤트 정보.., emit - 상태 발행 함수..
    on<AddTodoEvent>((event, emit){
      //state - Block 내에 자동으로 유지되는 변수.. Block의 상태
      List<Todo> newTodos = List.from(state.todos)
          ..add(event.todo);
      emit(TodosState(newTodos));//하위 위젯에 전파..
    });

    on<DeleteTodoEvent>((event, emit){
      List<Todo> newTodos = List.from(state.todos)
          ..remove(event.todo);
      emit(TodosState(newTodos));
    });

    on<ToggleCompletedTodoEvent>((event, emit){
      List<Todo> newTodos = List.from(state.todos);
      int index = newTodos.indexOf(event.todo);
      newTodos[index].toggleCompleted();
      emit(TodosState(newTodos));
    });

  }
  //이벤트 발생에 의한 상태 변경 정보....
  @override
  void onTransition(Transition<TodosEvent, TodosState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}