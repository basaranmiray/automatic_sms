import 'package:animated_splash/animated_splash.dart';
import 'package:automatic_sms/screens/smsScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: AnimatedSplash(
        imagePath: 'images/sms-icon.png',
        home: MyApp(),
        duration: 5,
        type: AnimatedSplashType.StaticDuration,
      ),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SmsScreen.id,
      routes: {
        SmsScreen.id: (context) => SmsScreen(),
      },
    );
  }
}

/**/
