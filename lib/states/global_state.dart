import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalState with ChangeNotifier {
  bool _openFirstTimeModal = false;
  String _authCode;

  bool get openFirstTimeModal => _openFirstTimeModal;
  String get authCode => _authCode;
  bool get hasAuthCode => _authCode != null;

  Future<void> initApp() async {
    await checkAuthCode();
  }

  Future<void> checkAuthCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("authCode")) {
      _authCode = prefs.getString("authCode");
      notifyListeners();
    }
  }
}
