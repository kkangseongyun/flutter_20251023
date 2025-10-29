import 'package:flutter/material.dart';
import './dto/DestinationDto.dart';
import './widgets/DestinationCard.dart';

class MainScreen extends StatelessWidget {
  //card 구성 데이터....
  List<DestinationDto> destinations = [
    DestinationDto(
      id: 1,
      image: 'assets/images/main_swiss.jpg',
      destination: '스위스',
      discount: '최대 20% 할인',
    ),
    DestinationDto(
      id: 2,
      image: 'assets/images/main_australia.jpg',
      destination: '호주',
      discount: '최대 10% 할인',
    ),
    DestinationDto(
      id: 3,
      image: 'assets/images/main_georgia.jpg',
      destination: '조지아',
      discount: '최대 20% 할인',
    ),
    DestinationDto(
      id: 4,
      image: 'assets/images/main_mongolia.jpg',
      destination: '몽골',
      discount: '최대 20% 할인',
    ),
    DestinationDto(
      id: 5,
      image: 'assets/images/main_nepal.jpg',
      destination: '네팔',
      discount: '최대 15% 할인',
    ),
    DestinationDto(
      id: 6,
      image: 'assets/images/main_hawaii.jpg',
      destination: '하와이',
      discount: '최대 5% 할인',
    ),
  ];

  //데이터 갯수 만큼 Card 위젯을 각 데이터로 생성해서 리턴...
  List<Widget> makeDestinationCard(){
    return destinations.map((destination){
      return DestinationCard(destination);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    //main 함수에 의해 처음 출력되는 곳의 root 에 MaterialApp
    //각 화면 단위 위젯의 root 는 Scaffold
    return Scaffold(
      appBar: AppBar(
        title: Text('MainScreen'),
      ),
      //화면에 여러 위젯을 나열하다가 화면을 벗어나게 되면..
      //노란색/검정색 패턴이 출력.. 경고다.. 화면 벗어났는데.. 스크롤 신경쓰지 않았다는..
      //SingleChildScrollView - 단일 위젯을 스크롤..
      //ListView.. - 여러 위젯을 스크롤...
      body: SingleChildScrollView(
        child: Column(
          children: [
            //특정 영역을 설정하기 위해서...
            Container(
              width: double.infinity,//가로방향으로는 최대한 확보...
              //이미지마다 사이즈가 다를 수 있다.. 최대한 이미지 사이즈를 유지하기는 하지만.. 300이상 출력은 할 수 없다..
              constraints: BoxConstraints(maxHeight: 300),
              child: Image.asset(
                'assets/images/main_bg_1.jpg',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '특가 여행지',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: (){

                    },
                    icon: Icon(Icons.arrow_drop_down, size: 20,),//flutter에서 제공되는 icon...
                    label: Text('전체 여행지 보기'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3899DD),
                        foregroundColor: Colors.white
                    ),
                  )
                ],
              ),
            ),
            Padding(
              //all - 4방향 동일 사이즈..
              //symmetric : 가로/세로 동일 사이즈..
              //only - 단일 방향..
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.count(//count 값에 의해 자동 개행.. 유저가 보기에 테이블 구조처럼..
                shrinkWrap: true,//GridView는 기본으로 무한 사이즈 확보.. 자신의 컨텐츠 크기만큼만 확보하라..
                physics: NeverScrollableScrollPhysics(),//GridView, ListView 는 자체 스크를 지원한다.. 자체스크롤 지원
                //하지 마라.. 화면 전체의 스크롤에 따르면 된다는 의도..
                crossAxisCount: 2,
                childAspectRatio: 0.85,//가로:세로 비율..
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: makeDestinationCard(),
              ),
            )
          ],
        ),
      )
    );
  }

}













