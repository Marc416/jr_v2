import 'package:flutter/material.dart';

//메뉴의 리스트 디자인
class MenuList extends StatefulWidget {
  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: null,
          accountEmail: null,
          decoration: BoxDecoration(
            color: Colors.yellow[600],
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.assignment,
            color: Colors.grey[850],
          ),
          title: Text('러닝기록'),
          onTap: () {
            //이동할 페이지 함수넣기
            //이동할 페이지 함수넣기
            print(context);
            Navigator.pushNamed(
              context,
              '/record',
            );
          },
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            color: Colors.grey[850],
          ),
          title: Text(
            '환경설정',
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
