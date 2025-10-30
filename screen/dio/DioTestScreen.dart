import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class DioTestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
     return DioTestScreenState();
  }
}

class DioTestScreenState extends State<DioTestScreen> {
  //서버에서 받은 데이터..
  List datas = [];

  //서버에 전송할 데이터..
  int page = 1;
  int seed = 1;

  //ListView에 설정해서.. ListView의 스크롤을 제어하거나.. 스크롤 정보를 획득하거나..
  ScrollController controller = ScrollController();

  //서버 요청을 하는 함수..
  //Future...미래에 발생하는 데이터..
  //비동기를 위해서.. 이 함수를 호출한 곳에서 이 함수의 업무가 끝날때 까지 대기하지 않게 하기 위해서..
  //async 로 선언된 함수의 리턴 타입은 Future 타입이고.. 자동으로.. 이함수를 호출하면 바로 Future 가 리턴된다..
  Future<List<dynamic>> dioTest() async {
    try{
      var dio = Dio(BaseOptions(
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 5),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json'
        }
      ));
      //실제 네트워킹 요청..
      Response<dynamic> response = await dio.get(
        'https://randomuser.me/api?seed=${seed}&page=${page}&results=20'
      );
      //실제 데이터 발생 순간.. 이 함수를 호출한 곳에서 Future에.. 콜백을 등록해 놨을 것이다.. 그 콜백이 실행..
      return response.data['results'];
    }catch(e){
      print(e);
    }
    return [];
  }

  //ListView 스크롤이 발생했을때.. 이벤트 콜백..
  scrollListener() async {
    //마지막까지 스크롤 된 것인지에 대한 판단..
    if(controller.offset == controller.position.maxScrollExtent &&
        !controller.position.outOfRange){
      //마지막까지 스크롤 되었다면..
      //그 다음 페이지 데이터를 서버에 요청..
      page++;
      List result = await dioTest();
      setState(() {
        datas.addAll(result);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    //스크롤 이벤트 등록..
    controller.addListener(scrollListener);
    //초기 데이터 획득..
    //리턴은 Future이다..실제 데이터 발생시에 실행될 콜백함수 등록..
    dioTest().then((value){
      setState(() {
        datas = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<void> refresh() async {
    page = 1;
    seed++;
    List result = await dioTest();
    setState(() {
      datas = result;
    });
  }
  

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dio'),
        ),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: ListView.separated(
            controller: controller,
            itemCount: datas.length,
            itemBuilder: (BuildContext context, int position) {
              return ListTile(
                contentPadding: EdgeInsets.all(5),
                title: Text(
                    "${datas[position]["name"]["first"]} ${datas[position]["name"]["last"]}"),
                subtitle: Text(datas[position]["email"]),
                leading: CircleAvatar(
                  radius: 25,
                  child: ClipOval(
                    child:
                    Image.network(datas[position]["picture"]['thumbnail']),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int position) {
              return Divider(
                color: Colors.black,
              );
            },
          ),
        )
    );
  }
}