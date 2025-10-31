import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformScreen extends StatefulWidget {
  @override
  PlatformScreenState createState() => PlatformScreenState();
}

class PlatformScreenState extends State<PlatformScreen> {


  String? resultMessage;
  String? receiveMessage;

  Future<Null> nativeCallChannel() async {
    //네이티브와 연동하기 위한 채널을 하나 만든다..
    //필요하다면.. 하나의 앱에서 여러 채널을 만들어도 된다..
    //매개변수 이름이 중요하다. 채널 이름이다. 네이티브 채널 이름과 동일해야 한다..
    const channel = BasicMessageChannel<String>('myMessageChannel', StringCodec());
    //네이티브에 데이터를 전달해서 일 시키기..
    //리턴 값은 네이티브에서 리턴 시킨 결과값..
    String? result = await channel.send('Hello, I am flutter message');
    setState(() {
      resultMessage = result;
    });

    //네이티브가 먼저 채널을 통해 전달한 데이터를 수신하기..
    //실행시킬 콜백만 채널에 등록..
    channel.setMessageHandler((String? message) async {
      setState(() {
        receiveMessage = message;
      });
      return 'Hi from Dart';//리턴 시킨 문자열이.. 네이티브에 결과 데이터로 전달된다..
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Channel Test")),
        body: Center(
          child: Column(
            children: (<Widget>[
              Text('result message : $resultMessage'),
              Text('receive message : $receiveMessage'),
              ElevatedButton(
                  onPressed: nativeCallChannel,
                  child: Text('channel test'),
              ),
            ]),
          ),
        )
    );
  }
}