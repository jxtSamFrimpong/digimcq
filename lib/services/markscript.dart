import 'package:digimcq/services/markscheme.dart';
import 'package:digimcq/utils/baseurl.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

Future getMarkScript(
    String file_id, String test_id, int end_number, List mark_scheme) async {
  print('inside markscheme');
  print(file_id);
  print(test_id);
  print(end_number);
  bool scheme_or_paper = false;

  Response response;
  var dio = Dio();

  //String BASE_URL = 'http://20.241.133.246:8080/mark_scheme';
  String url = BASE_URL + 'mark_scheme';

  var params = {
    "file_id": file_id,
    "test_id": test_id,
    "end_number": end_number,
    "scheme_or_paper": scheme_or_paper,
    "mark_scheme": mark_scheme
  };

  response = await dio.post(url, data: jsonEncode(params));
  // if (response.statusCode == 200) {
  //   return response.data;
  // } else {
  //   return {"error": "error"};
  // }
  //print(response.data);
  print('mark script function working');
  return response.data;
}
