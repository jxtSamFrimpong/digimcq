import 'dart:convert';
import 'dart:io';
import '../dummyData/markschemedummy.dart' as dummy;
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

String exampleFileID =
    'BQACAgQAAxkDAAMdYxTdLLZihZ9XgkVNgMSvyoxCLj4AAhsOAAJBtahQafJZ26IrH-YpBA';

wakeUpServer() async {
  Response response;
  var dio = Dio();

  String BASE_URL = 'http://20.237.63.30:8080/';

  response = await dio.get(BASE_URL);
  try {
    print(response.data.toString());
  } catch (e) {
    print(e);
  }
}

Future sendFileGetID(file_Path) async {
  Response response;
  var dio = Dio();
  String BASE_URL = 'http://52.188.132.234:8080/teleStorageGetFileID';
  var formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(file_Path),
    // 'files': [
    //   await MultipartFile.fromFile('./text1.txt', filename: 'text1.txt'),
    //   await MultipartFile.fromFile('./text2.txt', filename: 'text2.txt'),
    // ]
  });
  response = await dio.post(BASE_URL, data: formData);
  print(response.data.toString());
  return response.data;
}

Future markScript(file_id, test_id, end_number, mark_scheme) async {
  Response response;
  var dio = Dio();

  String BASE_URL = 'http://20.237.63.30:8080/mark_scheme';
  bool scheme_or_paper = false;

  var params = {
    "file_id": file_id,
    "test_id": test_id,
    "end_number": end_number,
    "scheme_or_paper": scheme_or_paper,
    "mark_scheme": mark_scheme,
  };

  response = await dio.post(
    BASE_URL,
    // options: Options(headers: {
    //   HttpHeaders.contentTypeHeader: "application/json",
    // }),
    data: jsonEncode(params),
  );
  return response.data;
}

Future markScheme(file_id, test_id, end_number) async {
  Response response;
  var dio = Dio();

  String BASE_URL = 'http://52.188.132.234:8080/mark_scheme';
  bool scheme_or_paper = true;

  var params = {
    "file_id": file_id,
    "test_id": test_id,
    "end_number": end_number,
    "scheme_or_paper": scheme_or_paper,
  };

  response = await dio.post(BASE_URL, data: jsonEncode(params));
  // if (response.statusCode == 200) {
  //   return response.data;
  // } else {
  //   return {"error": "error"};
  // }
  print(response.data);
  return response.data;
}

void main() async {
  //await wakeUpServer();

  //TODO teleStorageGetFileID
  var file_ids = await sendFileGetID('/Users/ewintil/Downloads/aha.jpeg');
  // if (file_ids != null) {
  //   print(file_ids);
  // }

//TODO markScheme
  Map scheme = await markScheme(exampleFileID, 'test_id', 40);
  if (scheme != null) {
    print(scheme['data']['scheme']);
  }

  //TODO: mark script example
  // Map dummy_scheme = dummy.markschemedummy;
  // Map mark_script;
  // mark_script = await markScript(
  //     exampleFileID, 'test_id', 40, dummy_scheme['data']['scheme']);
  // if (mark_script != null) {
  //   print(mark_script);
  // }
}
