// To parse this JSON data, do
//
//     final teleStorage = teleStorageFromJson(jsonString);

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../utils/baseurl.dart';

TeleStorage teleStorageFromJson(String str) =>
    TeleStorage.fromJson(json.decode(str));

String teleStorageToJson(TeleStorage data) => json.encode(data.toJson());

class TeleStorage {
  TeleStorage({
    required this.data,
  });

  Data data;

  factory TeleStorage.fromJson(Map<String, dynamic> json) => TeleStorage(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.fileId,
    required this.fileUniqueId,
  });

  String fileId;
  String fileUniqueId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        fileId: json["file_id"],
        fileUniqueId: json["file_unique_id"],
      );

  Map<String, dynamic> toJson() => {
        "file_id": fileId,
        "file_unique_id": fileUniqueId,
      };
}

Future sendFileGetID(file_path) async {
  var url = BASE_URL + "teleStorageGetFileID";
  // Response response;
  // var dio = Dio();
  //String BASE_URL = 'http://52.188.132.234:8080/teleStorageGetFileID';
  // var formData = FormData.fromMap({
  //   'file': await MultipartFile.fromFile(file_path),
  // });
  // response = await dio.post(url, data: formData);
  // // print(response.data.toString());
  // // print('frm mol');
  // // print(teleStorageFromJson(response.data.toString()));
  // if (response.statusCode == 200) {
  //   print(teleStorageFromJson(response.data.toString()).data.fileId);
  //   return teleStorageFromJson(response.data.toString());
  // }
  // return teleStorageFromJson(response.data.toString());

  // var request = http.MultipartRequest('POST', Uri.parse(url));
  // request.files.add(http.MultipartFile('picture',
  //     File(file_path).readAsBytes().asStream(), File(file_path).lengthSync(),
  //     filename: file_path.split("/").last));
  // var res = await request.send();
  // print(2);
  // print(await res.stream.bytesToString());
  // return teleStorageFromJson(res.toString());

  var request = http.MultipartRequest(
      'POST', Uri.parse('http://52.188.132.234:8080/teleStorageGetFileID'));
  request.files.add(await http.MultipartFile.fromPath('file', file_path));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    return jsonEncode(await response.stream
        .bytesToString()
        .then((value) => value.toString()));
    //return await response.stream.bytesToString();
    // var something = await response.stream.bytesToString().toString();
    // print('maybe');
    // print(teleStorageFromJson(something));
    // return teleStorageFromJson(await response.stream.bytesToString());
  } else {
    // return teleStorageFromJson(await response.stream.bytesToString());
    return await response.stream.bytesToString();
  }
}

// Future<Welcome> submitData(String name, String job) async {
//   var response = await http.post(Uri.https('reqres.in', 'api/users'),
//       body: {"name": name, "job": job});
//   var data = response.body;
//   print(data);

//   if (response.statusCode == 201) {
//     String responseString = response.body;
//     return welcomeFromJson(responseString);
//   } else {
//     return welcomeFromJson('{"error":"error"}');
//   }
// }

// Future<Map> sendFileGetID(file_Path) async {
//   Response response;
//   var dio = Dio();
//   String BASE_URL = 'http://20.237.63.30:8080/teleStorageGetFileID';
//   var formData = FormData.fromMap({
//     'file': await MultipartFile.fromFile(file_Path),
//     // 'files': [
//     //   await MultipartFile.fromFile('./text1.txt', filename: 'text1.txt'),
//     //   await MultipartFile.fromFile('./text2.txt', filename: 'text2.txt'),
//     // ]
//   });
//   response = await dio.post(BASE_URL, data: formData);
//   //print(response.data);
//   return jsonDecode(response.data);
// }
