import 'package:flutter/material.dart';
import 'package:flutter_lab/screen/main/dto/DestinationDto.dart';
import './widgets/DetailMainWidget.dart';
import './widgets/DetailNewsWidget.dart';

//bottom navigation bar의 탭 버튼 클릭시 화면 조정되어야 해서..
class DetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetailScreenState();
  }
}

//SingleTickerProviderStateMixin - 탭 터치시의 에니메이션 효과를 위해서..
class DetailScreenState extends State<DetailScreen> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;//현재 선택된 탭의 index...

  List<Widget> widgets = [
    DetailMainWidget(),
    DetailNewsWidget()
  ];

  //탭 버튼 클릭 이벤트 콜백..
  onItemTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //화면전환시 전달된 데이터 획득...
    Map<String, Object> args = ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    DestinationDto dto = args['destination'] as DestinationDto;

    return Scaffold(
      //NestedScrollView - 화면에 같이 나오는 하나의 위젯이 스크롤 될때 다른 위젯도 같이 스크롤 되게..
      //ListView에서 스크롤이 발생이 되면.. AppBar가 같이 스크롤 되게 하고 싶다..
      //스크롤 정보를 전달하는 중재자가 있어야 한다.. 그 역할자다..
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return [
              //NestedScrollView 에 의해 스크롤 정보가 전달된다고 하더라도.. 그 스크롤 정보를 받아서 자신을 접을수 있는
              //위젯이어야 한다.. 일반 AppBar는 그 능력이 없다..
              //접히는 AppBar를 구현하겠다면.. SliverAppBar
              SliverAppBar(
                expandedHeight: 250.0,
                //접혔다가.. 다시 거꾸로 시크롤 할때.. 처음부터 나타날것인가? true, 맨 마지막에 끌려 나올것인가? false
                floating: false,
                //접히는데 한줄은 남길 것인가? true - 다 접혀서 완전히 사라질 것인가? false
                pinned: true,
                backgroundColor: Color(0xFF3899DD),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(dto.destination, style: TextStyle(color: Colors.white),),
                  titlePadding: EdgeInsets.only(left: 56, bottom: 16),
                  //앱바바 확장되었을 때 타이틀의 크기 배율 설정..
                  expandedTitleScale: 1.0,
                  background: Image.asset(
                    'assets/images/detail_main.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ];
          },
          body: widgets.elementAt(selectedIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,//탭 버튼 클릭시에 버튼 부분의 애니메이션 효과 적용..
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Main',
            backgroundColor: Color(0xFF3899DD)//이 탭 버튼이 클릭되었을 때.. navigation bar 전체의 백그라운드 색상..
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'News',
              backgroundColor: Colors.red
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber,
        onTap: onItemTapped,
      ),
    );
  }
}
















