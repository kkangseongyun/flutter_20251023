import 'package:flutter/material.dart';
import 'package:flutter_lab/screen/detail/DetailScreen.dart';
import '../dto/DestinationDto.dart';

class DestinationCard extends StatelessWidget{
  DestinationDto destinationDto;

  DestinationCard(this.destinationDto);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,//위에 떠 있는 듯한 효과...
      //카드 모양.. round rect, circle.. 등 여러 모양 제공..
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      //InkWell - 자체 UI 는 없다.. 오직.. 이벤트 처리를 위해서..
      //이벤트만을 목적으로 하는 위젯이.. InkWell 과 GestureDetector..
      //GestureDetector - 이벤트만.. 이벤트 발생시 자체 UI 효과는 없다..
      //InkWell - 이벤트 제공.. 이벤트 발생시.. 잉크 번지는 듯한 UI 효과 제공..
      child: InkWell(
        onTap: (){
          // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen()));
          Navigator.pushNamed(context, '/detail', arguments: {'destination': destinationDto});
        },
        //이벤트 발생시.. 잉크 번지는 UI 효과가 어느 범위까지 나와야 하는가..
        //이 설정이 없으면.. card 밖에 까지.. 번지는 효과가 나올수 있다..
        borderRadius: BorderRadius.circular(10),
        child: Padding(
            padding: EdgeInsets.all(10.0),//테두리에서 얼마나 여백을 둬서 컨텐츠를 위치할 것인가..
            //all. - 4방향 동일 여백..
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    //이미지를 출력하고자 한다.. 이미지는 사각형이다.. 우리가 원하는데로 clip, 잘라서...
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      //애셋 이미지 로딩.. 생성자...
                      child: Image.asset(
                        destinationDto.image,
                        width: 150,
                        fit: BoxFit.cover,//이미지 원본 사이즈와 화면에 출력되는 사이즈가 다른 경우 어떻게 출력할 것인가?
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4,),//사이즈만 확보하는 위젯...
                Text(
                  destinationDto.destination,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  destinationDto.discount,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}