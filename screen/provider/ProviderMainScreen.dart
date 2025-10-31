import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './HomeTodoScreen.dart';
import '../../provider/TodosModel.dart';

//provier 데이터를 이용하는 모든 위젯의 공통의 조상역할..
//provider 데이터 등록..
class ProviderMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodosModel(),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}