import 'package:flutter/material.dart';

class Counter extends ChangeNotifier {
  var _count = 0;

  int get getCounter {
    return _count;
  }

  void incrementCounter() {
    _count += 1;
    notifyListeners();
  }
}

class User extends ChangeNotifier {
  late Object _user_credentials;

  get getUserCredentials {
    if (_user_credentials == null) {
      return;
    }
    return _user_credentials;
  }

  setUserCredentials(cred) {
    this._user_credentials = cred;
    notifyListeners();
  }
}
