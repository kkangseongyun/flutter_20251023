main() {
  //optional 로 선언되었다.. 함수 호출 시점에 매개변수 데이터가 전달되지 않을 수도 있다..
  //초기값은? nullable 로 선언하거나 default 값을 명시하거나..
  void funtion1(bool data1, { String? data2, int data3 = 0 }){

  }
  funtion1(true);
  funtion1(true, data2: "hello", data3: 10);
  //이름이 명시되어서.. 순서는 의미가 없다..
  funtion1(true, data3: 20, data2: "world");
  funtion1(true, data3: 30);

  //positional parameter................optional 이다.. 순서를 맞추어서 사용해야 한다..
  void funtion2(bool data1, [ String? data2, int data3 = 0 ]){

  }
  funtion2(true);
  // funtion2(true, data3: 20, data2: "hello");//이름을 명시할 수 없다.. error....
  funtion2(true, "hello");
  funtion2(true, "world", 20);
}