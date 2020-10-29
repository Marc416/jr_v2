import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jr_v1/Menu/thisweek.dart';

class Record extends StatefulWidget {
  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Record> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        title: Text(
          '러닝기록',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Body(context),
    );
  }

  Widget Body(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 40),
              alignment: Alignment.center,
              child: Text(
                '48.07' + 'KM',
                style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                    minWidth: 180,
                    height: 50,
                    buttonColor: Colors.grey[100],
                    child: RaisedButton(
                      child: Text(
                        '이번주',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {},
                    )),
                ButtonTheme(
                    minWidth: 180,
                    height: 50,
                    buttonColor: Colors.grey[100],
                    child: RaisedButton(
                      child: Text(
                        '달',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {},
                    )),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            ThisWeekRecord(),
          ],
        ),
      ),
    );
  }
}
