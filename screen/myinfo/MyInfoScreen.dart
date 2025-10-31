import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lab/provider/MyInfoModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MyInfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyInfoScreenState();
  }
}

class MyInfoScreenState extends State<MyInfoScreen> {
  //이곳에서 발생하는 데이터는 맞지만.. 이곳에서 관리하는 것이 아니라.. 상위에서 상태로 관리한다...
  // String? email = '';
  // String? phone = '';
  // String userImage = 'assets/images/user_basic.jpg';
  
  //Form 위젯을 이용할거다.. StatefulWidget이다.. 임의순간... Form 의 State 함수를 호출해야 한다..
  //key 설정해서.. key 로 필요한 순간 위젯의 State 객체 획득이 필요하다..
  final formKey = GlobalKey<FormState>();

  //Form 을 사용하기 때문에 각 입력데이터 획득은 Controller 없이도 가능하기는 하지만..
  //이 화면이 출력될때.. 초기데이터를 State에서 획득해서.. 그럴려면 controller 있어야 한다..
  late TextEditingController emailController;
  late TextEditingController phoneController;

  //gallery 앱 연동..
  Future<void> openGallery() async {
    ImagePicker picker = ImagePicker();
    //gallery 목록 화면을 띄우고.. 유저가 선택한 사진 정보를 받는다..
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      Provider.of<MyInfoModel>(context, listen: false)
          .saveMyInfo(userImage: image.path);//사진 경로를 앱 전역에 상태 데이터로 설정..
    }
  }

  //camera 연동..
  Future<void> openCamera() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.camera);
    if(image != null){
      Provider.of<MyInfoModel>(context, listen: false)
          .saveMyInfo(userImage: image.path);
    }
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    phoneController = TextEditingController();

    //controller에 값을 추가해서 화면에 출력되게 할거다..
    //위치가 initState 이다.. 최초 한번 하면 되기때문에.. 코드 위치는 이곳이 맞다..
    //initState가 호출될 시점에 build 함수가 호출이 되지 않았다.. 위젯이 준비되지 않은 상태이다..
    //이 상태에서 위젯에 무언가를 설정할 수 없다..
    //위젯이 준비가 완료된 후에 실행될 코드를 등록한다..
    WidgetsBinding.instance.addPostFrameCallback((_){
      //이 함수는 위젯이 준비가 완료된 후에 호출된다..
      //상위의 상태 획득..
      final model = Provider.of<MyInfoModel>(context, listen: false);
      emailController.text = model.email;
      phoneController.text = model.phone;
    });

  }

  @override
  void dispose(){
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
  
  Future<void> saveData() async {
    //유저 입력 정보 저장..
    print('email : ${emailController.text}, phone : ${phoneController.text}');
    //신규 데이터가 발생했다.. 상위 상태에 등록..
    final model = Provider.of<MyInfoModel>(context, listen: false);
    model.saveMyInfo(
      email: emailController.text,
      phone: phoneController.text,
    );

    //위에서 앱의 상태로 설정 했고..
    //그 내용이 db 에 저장도 되어야 한다..
    model.insertDB();

    Navigator.pop(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 정보'),
        actions: [
          //AppBar 에 제공하는 버튼... 흔히 메뉴, action button 이라고 칭한다..
          TextButton(
              onPressed: (){
                //key 로 위젯의 State 획득..
                final form = formKey.currentState;
                //유효성 검증...
                //validate() 에 의해 모든 하위의 validator() 함수 호출.. 전체 null 리턴이면 전체 유효 - true
                //하나라도 null이 아닌 문자열을 리턴하면 전체 invalid - false
                if(form?.validate() ?? false){
                  form?.save();//모든 하위의 onSaved() 함수 호출.. 적절하게.. 알아서 데이터 저장되었을 거다..
                  saveData();
                }
              }, 
              child: Text('저장', style: TextStyle(color: Colors.black, fontSize: 16),)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          //상위의 데이터를 출력....
          child: Consumer<MyInfoModel>(
            builder: (context, model, child){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30,),
                  Card(
                    elevation: 0,
                    shape: CircleBorder(),
                    // clipBehavior: Clip.antiAlias,
                    child: Container(
                      width: 150,
                      height: 150,
                      // child: Image.asset(model.userImage, fit: BoxFit.cover,),
                      child: model.userImage.startsWith('assets/')
                        ? Image.asset(model.userImage, fit: BoxFit.cover,)
                        : Image.file(File(model.userImage), fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(height: 24,),
                  ElevatedButton(onPressed: (){
                    openGallery();
                  }, child: Text('Gallery App')),
                  SizedBox(height: 24,),
                  ElevatedButton(onPressed: (){
                    openCamera();
                  }, child: Text('Camera App')),
                  SizedBox(height: 24,),
                  Form(
                    key: formKey,//key 를 설정하고 이 key 로 Form 의 State 획득..
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //유저 키보드 입력 위젯의 기본은 TextField 이지만.. Form 과 상호 작용 준비가 된 TextFormField
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                          //Form 의 State 함수인 validate() 함수를 호출하면 Form 하위 위젯의 모든 validator() 함수가 자동 호출
                          //매개변수는 유저 입력 데이터..
                          validator: (value){
                            if(value?.isEmpty ?? false){
                              return 'please enter your email';//문자열 리턴.. invalid 로 본다.. 에러 출력 문자열이다..
                            }
                            return null;//valid 상황으로 판단..
                          },
                          //Form State 의 save() 호출하면 모든 하위의 onSaved() 함수 자동 호출.. 매개변수는 유저 입력 데이터
                          // onSaved: (value) {
                          //   setState(() {
                          //     email = value;
                          //   });
                          // },
                        ),
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(labelText: 'Phone'),
                          validator: (value){
                            if(value?.isEmpty ?? false){
                              return 'please enter your phone';
                            }
                            return null;
                          },
                          // onSaved: (value) {
                          //   setState(() {
                          //     phone = value;
                          //   });
                          // },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          )
        ),
      ),
    );
  }
}