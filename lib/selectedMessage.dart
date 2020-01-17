import 'package:flutter/material.dart';
import 'package:automatic_sms/receiving_sending_sms.dart';
import 'constants.dart';

class SelectedMessage extends StatelessWidget {
  const SelectedMessage({this.receivingSendingSms});

  final ReceivingSendingSms receivingSendingSms;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Seçili Mesaj: ',
          style: kSelectedMessage_TextStyle,
        ),
        receivingSendingSms.message == null
            ? Text(
                '',
                style: kSelectedTextMessage_TextStyle,
              )
            : Text(
                receivingSendingSms.message,
                style: kSelectedTextMessage_TextStyle,
              )
      ],
    );
  }
}
