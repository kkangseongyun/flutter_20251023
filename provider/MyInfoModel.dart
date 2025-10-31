import 'package:flutter/material.dart';
import 'package:flutter_lab/db/DatabaseHelper.dart';

//provider 로 관리하는 사용자 정보..
class MyInfoModel extends ChangeNotifier {
  String email = '';
  String phone = '';
  String userImage = 'assets/images/user_basic.jpg';

  //실제 화면을 제공하는 위젯에서 DBMS 를 직접 할 수도 있지만..
  //우리의 경우는 DBMS 데이터가 provider로 관리되고 있음으로.. provider의 데이터에서 직접 dbms 하겠다..
  DatabaseHelper dbHelper = DatabaseHelper();

  void saveMyInfo({String? email, String? phone, String? userImage}){
    bool hasChanged = false;

    if(email != null){
      this.email = email;
      hasChanged = true;
    }
    if(phone != null){
      this.phone = phone;
      hasChanged = true;
    }
    if(userImage != null){
      this.userImage = userImage;
      hasChanged = true;
    }

    if(hasChanged){
      notifyListeners();//변경 사항 하위 전파..
    }
  }

  void insertDB() async {
    try{
      await dbHelper.insertMyInfo({
        'email': email,
        'phone': phone,
        'photo': userImage,
      });
      print('db 저장 성공..');
    }catch(e){
      print('db 저장 실패 : $e');
    }
  }

  void loadUserInfo() async {
    try{
      final data = await dbHelper.getMyInfo();
      if(data.isNotEmpty){
        //상태 데이터로 유지..
        email = data.first['email'];
        phone = data.first['phone'];
        userImage = data.first['photo'];
      }
      //하위 위젯에 반영..
      notifyListeners();
      print('db 로딩 성공');
    }catch(e){
      print('db 로딩 실패 : $e');
    }
  }
}














