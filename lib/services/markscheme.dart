// To parse this JSON data, do
//
//     final markScheme = markSchemeFromJson(jsonString);
import 'package:http/http.dart' as http;
import 'dart:convert';
//import '../utils/baseurl.dart';
import 'package:dio/dio.dart';

MarkScheme markSchemeFromJson(String str) =>
    MarkScheme.fromJson(json.decode(str));

String markSchemeToJson(MarkScheme data) => json.encode(data.toJson());

class MarkScheme {
  MarkScheme({
    required this.data,
  });

  Data data;

  factory MarkScheme.fromJson(Map<String, dynamic> json) => MarkScheme(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.scheme,
  });

  List<Scheme> scheme;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        scheme:
            List<Scheme>.from(json["scheme"].map((x) => Scheme.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "scheme": List<dynamic>.from(scheme.map((x) => x.toJson())),
      };
}

class Scheme {
  Scheme({
    required this.answer,
    required this.answerTo,
  });

  String answer;
  int answerTo;

  factory Scheme.fromJson(Map<String, dynamic> json) => Scheme(
        answer: json["answer"],
        answerTo: json["answer_to"],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "answer_to": answerTo,
      };
}

Future getMarkScheme(String file_id, String test_id, int endNumber) async {
  print('inside markscheme');
  print(file_id);
  print(test_id);
  print(endNumber);
  bool scheme_or_paper = true;

  Response response;
  var dio = Dio();

  String BASE_URL = 'http://20.241.133.246:8080/mark_scheme';

  var params = {
    "file_id": file_id,
    "test_id": test_id,
    "end_number": endNumber,
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
