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
  var _user_credentials;
  var _test_doc_id;
  var _student_doc_id;
  var _endNumber;
  var _appName = 'mcq grader';
  var _testName;
  var _code;
  var _class;
  var _chosenStudent;

  get getAppName {
    return _appName;
  }

  get getUserCredentials {
    if (_user_credentials == null) {
      return;
    }
    return _user_credentials;
  }

  void setUserCredentials(cred) {
    this._user_credentials = cred;
    notifyListeners();
  }

  get getTestDocID {
    if (_test_doc_id == null) {
      return '';
    }
    return _test_doc_id;
  }

  void setTestDocID(id) {
    this._test_doc_id = id;
    notifyListeners();
  }

  get getStudentDocID {
    if (_student_doc_id == null) {
      return '';
    }
    return _student_doc_id;
  }

  void setStudentDocId(id) {
    this._student_doc_id = id;
    notifyListeners();
  }

  get getEndNumber {
    return this._endNumber;
  }

  setEndNumber(val) {
    this._endNumber = val;
    notifyListeners();
  }

  get getTestName {
    if (this._testName != null) {
      return _testName;
    } else {
      return '';
    }
  }

  void setTestName(name) {
    this._testName = name;
    notifyListeners();
  }

  get getCode {
    if (_code == null) {
      return '';
    }
    return _code;
  }

  void setCode(code) {
    this._code = code;
    notifyListeners();
  }

  get getClass {
    if (_class == null) {
      return '';
    }
    return _user_credentials;
  }

  void setClass(cred) {
    this._class = cred;
    notifyListeners();
  }

  get getChosenStudent {
    if (_chosenStudent == null) {
      return;
    }
    return _chosenStudent;
  }

  void setChosenStudent(cred) {
    this._chosenStudent = cred;
    notifyListeners();
  }
}
