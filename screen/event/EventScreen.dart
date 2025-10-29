import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import './dto/EventDto.dart';
import './widgets/EventCard.dart';

class EventScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EventScreenState();
  }
}

class EventScreenState extends State<EventScreen> {
  // EventDto dto = EventDto(
  //   'assets/images/main_australia.jpg', '호주', '시드니+멜버른', '1.1 ~ 2.1', '20%'
  // );

  List<EventDto> datas = [
    EventDto('assets/images/main_australia.jpg', '호주', '시드니+멜버른+브리즈번', '2.14(금) ~ 2.23(일)',
        '20%'),
    EventDto('assets/images/main_georgia.jpg', '조지아', '나리칼라+게르게티',
        '2.14(금) ~ 2.29(토)', '15%'),
    EventDto(
        'assets/images/main_hawaii.jpg', '하와이', '호놀룰루+마우이', '2.15(토) ~ 2.20(목)', '20%'),
    EventDto('assets/images/main_mongolia.jpg', '몽골', '울란바토르+알타이', '2.17(월) ~ 2.23(일)',
        '20%'),
    EventDto('assets/images/main_nepal.jpg', '네팔', '카트만두+ABC', '2.21(금) ~ 3.8(일)', '15%'),
  ];

  //데이터 갯수 만큼 위젯 객체 생성 리턴..
  List<EventCard> makeViewPagerWidgets() {
    return datas.map((dto){
      return EventCard(dto);
    }).toList();
  }

  //손가락 따라 순차적으로 화면을 출력시키는 위젯.. PageView
  //PageView 제어자..
  //우리가 이용하는 위젯은 화면 출력 정보만 가지는 VO.. 코드에서 위젯을 제어하기 위한 Controller 별도로 사용..
  PageController controller = PageController(
    initialPage: 0,//여러장의 화면중 초기에 뿌릴 화면..
    viewportFraction: 0.9,//현재 보이는 왼쪽, 오른쪽 화면을 얼마나 출력할 것인가? 1.0 - 현재 화면만..
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF3899DD),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,//controller 설정대로 화면이 나오며.. 유저가 화면을 조정한 정보값이 내부적으로 controller에 유지..
                children: makeViewPagerWidgets(),
              ),
            ),
            SmoothPageIndicator(
              controller: controller,//PageView에 설정한 동일 controller 지정해서.. PageView 의 조정 정보가 Indicator에서도 활용되게..
              count: 5,
              effect: WormEffect(
                dotColor: Colors.white,
                activeDotColor: Colors.yellow,
              ),
            ),
            SizedBox(height: 32.0,)
          ],
        ),
      ),
    );
  }
}