import 'package:sms/sms.dart';

class ReceivingSendingSms {
  String phoneNumber;
  String message;
  bool switchControl;
  String sendMessage;

  SmsSender sender = new SmsSender();
  SmsReceiver receiver = new SmsReceiver();

  void sending(String _phoneNumber, String _message, bool control) {
    if (switchControl) {
      phoneNumber = _phoneNumber;
      sendMessage = _message;
      SmsMessage message = new SmsMessage(phoneNumber, sendMessage);
      message.onStateChanged.listen((state) {
        if (state == SmsMessageState.Sent) {
          print("SMS is sent!");
        } else if (state == SmsMessageState.Delivered) {
          print("SMS is delivered!");
        }
      });
      sender.sendSms(message);
    }
  }

  receiving() {
    receiver.onSmsReceived.listen(
        (SmsMessage msg) => sending(msg.address, message, switchControl));
  }
}
