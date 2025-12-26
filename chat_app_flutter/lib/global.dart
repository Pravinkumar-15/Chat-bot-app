import 'package:chat_app_flutter/constants/constant.dart';
import 'package:rxdart/rxdart.dart';

class Global {
  static BehaviorSubject<Map<String, dynamic>> pageStateStream =
      BehaviorSubject<Map<String, dynamic>>.seeded({
        "index": 0,
        "state": PageState.home,
      });
  static BehaviorSubject<bool> isClickedHistory = BehaviorSubject<bool>.seeded(
    false,
  );
}
