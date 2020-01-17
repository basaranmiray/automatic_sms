import 'package:automatic_sms/constants.dart';
import 'package:flutter/material.dart';
import 'package:automatic_sms/messageList.dart';
import 'package:automatic_sms/preparedPackages.dart';
import 'package:automatic_sms/receiving_sending_sms.dart';
import 'package:automatic_sms/selectedMessage.dart';
import 'package:toast/toast.dart';

class SmsScreen extends StatefulWidget {
  static String id = 'smsScreen';
  @override
  _SmsScreenState createState() => _SmsScreenState();
}

class _SmsScreenState extends State<SmsScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  ReceivingSendingSms _receivingSendingSms = new ReceivingSendingSms();
  var _textController = TextEditingController();
  int selectIndex;
  bool switchControl = false;
  String switchTextHolder = 'Uygulama Kapalı';

  void toggleSwitch(bool value) {
    if (value == false) {
      setState(() {
        switchControl = true;
        _receivingSendingSms.switchControl = true;
        switchTextHolder = 'Uygulama Açık';
      });
    } else {
      setState(() {
        switchControl = false;
        _receivingSendingSms.switchControl = false;
        switchTextHolder = 'Uygulama Kapalı';
      });
    }
  }

  @override
  void initState() {
    _receivingSendingSms.switchControl = false;
    _receivingSendingSms.receiving();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey,
      appBar: new AppBar(
        backgroundColor: Colors.black,
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                switchTextHolder,
                style: kSwitchTextHolder_TextStyle,
              ),
            ],
          ),
          Switch(
              value: switchControl,
              activeColor: Colors.yellow,
              onChanged: toggleSwitch),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/MB.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'AutoSMS',
                  style: kTitle_TextStyle,
                ))
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          _textController.clear();
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: PreparedPackages(
                      selectIndex: selectIndex,
                      index: index,
                    ),
                    onTap: () {
                      setState(() {
                        selectIndex == index
                            ? selectIndex = null
                            : selectIndex = index;
                        _receivingSendingSms.message = messages[index]['name'];
                        print('Mesajınız seçildi');
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _textController.clear();
                      });
                    },
                    splashColor: Colors.blue,
                    focusColor: Colors.yellowAccent,
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
            SizedBox(height: 50),
            Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText: 'Geçici Mesaj Oluştur',
                      prefixIcon: Icon(Icons.message),
                      suffixIcon: InkWell(
                        child: Icon(
                          Icons.near_me,
                          color: Colors.red,
                        ),
                        onTap: () {
                          setState(() {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                            }
                            selectIndex = null;
                            FocusScope.of(context).requestFocus(FocusNode());
                            print(_receivingSendingSms.message);
                            Toast.show(
                                _receivingSendingSms.message == ''
                                    ? 'Mesaj yazmadınız'
                                    : _receivingSendingSms.message,
                                context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                          });
                        },
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: kActiveFormColour,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: kInactiveFormColour,
                      ),
                    ),
                    maxLength: 25,
                    onSaved: (value) {
                      return _receivingSendingSms.message = value;
                    },
                  ),
                ),
                SelectedMessage(receivingSendingSms: _receivingSendingSms),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
