import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/TodosBloc.dart';
import 'HomeTodoScreen.dart';

class BlocMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Bloc 을 등록해서.. 하위에서 이용하게..
    return BlocProvider<TodosBloc>(
      create: (context) => TodosBloc(),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );

  }
}