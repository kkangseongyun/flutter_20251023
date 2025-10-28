class MyClass {
  int no = 0;
  MyClass(){}
  void sayHello(){}
}

//클래스를 상속 관계로...
class Sub extends MyClass {

}
//클래스를 인터페이스로...
class InterfaceClass implements MyClass {
  //implements 에 등록한 클래스내에 선언된 모든 멤버가.. 오버라이드 되어야 한다..
  //생성자는 멤버가 아니다.. 생성자 제외..
  int no = 20;

  @override
  void sayHello() {
  }
}

mixin MyMixin {
  int mixinData = 10;
  void mixinFun(){}
  // MyMixin(){}//클래스 아니다.. 생성자는 추가할 수 없다..
}
class MyMixinClass with MyMixin {
  void sayHello(){
    //mixin 에 선언된 멤버를 자신 클래스 멤버처럼 이용...
    mixinData = 20;
    mixinFun();
  }
}