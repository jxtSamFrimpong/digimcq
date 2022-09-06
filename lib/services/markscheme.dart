// To parse this JSON data, do
//
//     final markScheme = markSchemeFromJson(jsonString);
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/baseurl.dart';

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

Future<MarkScheme> getMarkScheme(String file_id, String test_id, int endNumber) async{
  bool scheme_or_paper = true;
  var response = await http.post(
    Uri.https(BASE_URL, 'mark_scheme'),
    body:{
      "file_id":file_id,
      "test_id":test_id,
      "end_number":endNumber,
      "scheme_or_paper":scheme_or_paper
    }
    var data = response.body;
  print(data);

  if(response.statusCode==200){
    return markSchemeFromJson(data.toString());
  }else{
    return markSchemeFromJson(data.toString());
  }
  );
}
