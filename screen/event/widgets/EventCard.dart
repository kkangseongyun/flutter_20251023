import 'package:flutter/material.dart';
import '../dto/EventDto.dart';

class EventCard extends StatelessWidget {
  EventDto vo;

  EventCard(this.vo);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Color(0xFF3899DD),
        ),
        Align(//위젯의 위치...
          alignment: Alignment(0.0, 0.0),//center
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,//content 를 화면에 출력할 수 있는 정도의 사이즈만...
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRect(
                    child: Align(//Stack 하위에 주로 사용되지만 다른 layout 위젯에서도 사용 가능..
                      alignment: Alignment.center,
                      child: Image.asset(
                        vo.image,
                        width: 350,
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 120,
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),//EdgeInsets - padding, margin
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vo.title,
                          style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),//여백만 차지하는 위젯.. 아래의 위젯들이 부모영역에서 하단으로 밀린다..
                        Text(vo.content),
                        SizedBox(height: 4,),
                        Text(vo.date),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(//Align 처럼 위젯의 위치를 조정하기 위한 위젯...Stack 하위에서만 사용 가능..
                left: 30,
                bottom: 110,
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.black,
                  child: Text(
                    vo.discount,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}