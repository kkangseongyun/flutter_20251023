import 'package:flutter/material.dart';
import 'package:flutter_lab/provider/MyInfoModel.dart';
import 'package:provider/provider.dart';
import '../../myinfo/MyInfoScreen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          //drawer 상단...
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Consumer<MyInfoModel>(
              builder: (context, model, child){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    CircleAvatar(//둥근 이미지..
                      radius: 30,
                      backgroundColor: Colors.white,
                      // child: Icon(Icons.percent, size: 40, color: Colors.blue,),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image.asset(model.userImage, fit: BoxFit.cover,),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      // 'kim@example.com',
                      model.email,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                );
              },
            )
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('My Info'),
            // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyInfoScreen())),
            onTap: () => Navigator.pushNamed(context, '/myinfo'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('dio'),
            onTap: () => Navigator.pushNamed(context, '/dio'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('provider'),
            onTap: () => Navigator.pushNamed(context, '/provider'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('bloc'),
            onTap: () => Navigator.pushNamed(context, '/bloc'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('platform'),
            onTap: () => Navigator.pushNamed(context, '/platform'),
          )
        ],
      ),
    );
  }
}