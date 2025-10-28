class User {
  String? name;
  int? age;

  //생성자 매개변수로.. 멤버변수 초기화...
  //case 1
  // User(String name, int age){
  //   this.name = name;
  //   this.age = age;
  // }

  //case2 - 매개변수에서 직접.. 멤버변수 초기화..
  // User(this.name, this.age);

  //case3 - 매개변수를 활용해서 약간의 로직으로... 멤버 초기화..
  //초기화 영역에는 여러라인 작성 불가능하며.. this() 등 다른 생성자 호출구문과.. 멤버 초기화 구문만 추가 가능..
  User(String name, int age): this.name = name.toUpperCase(), this.age = age * 2;

  //생성자를 여러개 선언한다면.. named constructor....
  User.one(){}
  User.two(String name): this.one();

}

//이 클래스의 객체는 하나만 생성되어 이용되게 보장해야 한다...
class Singleton {
  int? data;
  //객체를 생성하려면.. 생성자가 있어야 한다.. 외부에서는 호출안되게 해야 한다.. 외부에서 호출하면 여러번 생성할 수 있기 때문에..
  Singleton._privateConstructor();
  static final Singleton _instance = Singleton._privateConstructor();
  //외부에서 객체 생성시에 호출할 생성자...
  //factory 생성자는 외부에서는 일반 생성자.. 그런데.. 호출 자체로 객체게 생성되지는 않는다..
  //생성자 내부에서 코드로 객체를 준비해서 리턴해야 한다..
  factory Singleton() {
    return _instance;
  }
}

main() {
  User obj1 = User("kim", 10);
  User obj2 = User.one();
  User obj3 = User.two("kim");

  Singleton a1 = Singleton();
  Singleton a2 = Singleton();
  a1.data = 10;
  a2.data = 20;
  print("${a1.data}, ${a2.data}");//20, 20

}