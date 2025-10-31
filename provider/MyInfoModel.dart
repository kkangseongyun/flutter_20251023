import 'package:flutter/material.dart';

//provider 로 관리하는 사용자 정보..
class MyInfoModel extends ChangeNotifier {
  String email = '';
  String phone = '';
  String userImage = 'assets/images/user_basic.jpg';

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
}