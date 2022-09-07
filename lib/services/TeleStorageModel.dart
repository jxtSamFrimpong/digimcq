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

  var request = http.MultipartRequest(
      'POST', Uri.parse('http://52.188.132.234:8080/teleStorageGetFileID'));
  request.files.add(await http.MultipartFile.fromPath('file', file_path));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    return jsonEncode(await response.stream
        .bytesToString()
        .then((value) => value.toString()));
  } else {
    // return teleStorageFromJson(await response.stream.bytesToString());
    return await response.stream.bytesToString();
  }
}
