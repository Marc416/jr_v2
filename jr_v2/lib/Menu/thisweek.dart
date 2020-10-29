import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget ThisWeekRecord() {
  return Container(
    child: Form(
      child: Column(
        children: <Widget>[
          Container(
              alignment:Alignment.centerLeft ,
              child: Text('월요일',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          Row(
            children: <Widget>[
              Image.asset('image/profile.jpg',
              width: 90 ,
              height: 90,
              ),
              SizedBox(width: 30,),
              //이미지
              RunData()
              //기록
            ],
          )
        ],
      ),
    ),
  );
}

Widget RunData() {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('2020.03.30'),
        Text('토요일 야간 러닝'),
        Row(
          children: <Widget>[
            Text('4.07km'),
            Text("'7'20/km"),
            Text('280kcal')

          ],
        )
      ],
    ),
  );
}