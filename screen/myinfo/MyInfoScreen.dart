import 'package:flutter/material.dart';

class MyInfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyInfoScreenState();
  }
}

class MyInfoScreenState extends State<MyInfoScreen> {
  String? email = '';
  String? phone = '';
  String userImage = 'assets/images/user_basic.jpg';
  
  //Form 위젯을 이용할거다.. StatefulWidget이다.. 임의순간... Form 의 State 함수를 호출해야 한다..
  //key 설정해서.. key 로 필요한 순간 위젯의 State 객체 획득이 필요하다..
  final formKey = GlobalKey<FormState>();
  
  Future<void> saveData() async {
    //유저 입력 정보 저장..
    print('email : $email, phone : $phone, photo : $userImage');
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
          child: Column(
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
                  child: Image.asset(userImage, fit: BoxFit.cover,),
                ),
              ),
              SizedBox(height: 24,),
              ElevatedButton(onPressed: (){}, child: Text('Gallery App')),
              SizedBox(height: 24,),
              ElevatedButton(onPressed: (){}, child: Text('Camera App')),
              SizedBox(height: 24,),
              Form(
                key: formKey,//key 를 설정하고 이 key 로 Form 의 State 획득..
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //유저 키보드 입력 위젯의 기본은 TextField 이지만.. Form 과 상호 작용 준비가 된 TextFormField
                    TextFormField(
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
                      onSaved: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Phone'),
                      validator: (value){
                        if(value?.isEmpty ?? false){
                          return 'please enter your phone';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          phone = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}