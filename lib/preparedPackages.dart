import 'package:automatic_sms/constants.dart';
import 'package:flutter/material.dart';
import 'package:automatic_sms/messageList.dart';

class PreparedPackages extends StatelessWidget {
  const PreparedPackages({this.selectIndex, this.index});

  final int selectIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kPreparedPackagesDecorator,
      padding: EdgeInsets.all(15.0),
      child: Card(
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(messagesIcon[index]['icon']),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedDefaultTextStyle(
                style: selectIndex == index
                    ? kSeletectedAnimation_TextStyle
                    : kDefaultAnimation_TextStyle,
                duration: const Duration(milliseconds: 300),
                child: Text(
                  messages[index]['name'],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
