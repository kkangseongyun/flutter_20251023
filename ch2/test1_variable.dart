main() {
  //다트의 모든 변수는 객체이다..
  int data1 = 10;
  print(data1.isEven);

  //int <-> double 은 캐스팅을 논할 수 없다.. 두 클래스는 상하위 관계에 있지 않다..
  // double data2 = data1;//error
  // int data3 = 10.0;//error...
  //기초타입 변형은 함수로 해야 한다..
  double data2 = data1.toDouble();
  int data3 = 10.0.toInt();

  //int <-> String
  String data4 = '10';
  int data5 = int.parse(data4);
  String data6 = data5.toString();


  //dart 언어는 강형언어이다.. var vs dynamic....
  //var 은 타입 유추 기법이다.. 대입되는 데이터로 타입이 고정된다..
  var a1 = 10;
  // a1 = true;//error...

  //var 로 선언하면서.. 값을 대입하지 않았다면...
  //dynamic type 으로 유추된다..
  var a2;
  a2 = 10;
  a2 = "hello";
  a2 = true;

  dynamic a3 = 10;
  a3 = "hello";


  //공식적으로 배열은 제공하지 않는다.. List 가 배열이고. 배열이 List 이다..
  //선언과 동시에 값을 줄 수 있는 경우..
  List<int> list1 = [10, 20, 30];
  list1.add(40);
  list1.forEach((element){
    print(element);
  });
  print("${list1[0]}, ${list1[1]}");

  //사이즈를 고정해서.. 배열처럼 사용하고 싶다..
  //filled 라는 생성자를 이용해서 객체 생성...
  //객체 생성시에 new 예약어 써도 되고.. 안써도 되고...
  List list2 = new List.filled(3, null);
  list2[0] = "hello";
  list2[1] = "world";
  // list2.add("aaa");//runtime error... Cannot add to a fixed-length list

  //map......................
  Map map1 = {1: 10, "one": "hello"};
  print("${map1['one']}");
  map1['one'] = "world";
}