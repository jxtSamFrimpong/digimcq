import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'dart:math';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class FileManager {
  // var test_doc_id;
  // FileManager(this.test_doc_id);

  generateStudentData(snapshtData) {
    var _myList = <Map>[];
    //TODO
    //   for (var i = 0; i < 200; i++) {
    //     var _ = <String, dynamic>{};
    //     _["score"] = rand.nextInt(200);
    //     _["out_of"] = 200;
    //     _["percentage"] = rand.nextDouble() * 100;
    //     _["img_url"] = "hhsbdkjfb";
    //     _["answers"] = [
    //       {"answer": "a", "answer_to": 1}
    //     ];
    //     _myList.add(_);
    //   }

    return _myList;
  }

  saveDataToJSON(file_name, snapshot_lists) async {
    var _myStudentsData = json.encode(
        snapshot_lists); //the array is to be replaced by data in snapshots
    try {
      final directory = await getApplicationDocumentsDirectory();
      //print(directory.path);
      final File file = File('${directory.path}/${file_name}.JSON');
      await file.writeAsString(_myStudentsData, mode: FileMode.write);
      //print(file.path);
    } catch (e) {
      print(e);
    }
  }

  saveDataToCSV(List snapshot_lists, file_name) async {
    const headers = "student_index, score, percentage, out_of, grade";

    try {
      final directory = await getApplicationDocumentsDirectory();
      //print(directory.path);
      final File file = File('${directory.path}/${file_name}.csv');
      await file.writeAsString(headers, mode: FileMode.write);
      print(file.path);
    } catch (e) {
      print(e);
    }
    for (var i = 0; i < snapshot_lists.length; i++) {
      // writeContentsToTxtFile(test_doc_id,
      //     "${rand.nextInt(9999999)}, ${rand.nextInt(200)}, ${rand.nextDouble() * 100}, 200");

      try {
        final directory = await getApplicationDocumentsDirectory();
        final File file = File('${directory.path}/${file_name}.csv');
        await file.writeAsString(
            "\r\n" +
                "${snapshot_lists[i]["student_idx"]}, ${snapshot_lists[i]["score"]}, ${snapshot_lists[i]["percentage"]}, ${snapshot_lists[i]["out_of"]}, ${snapshot_lists[i]["grade"]}",
            mode: FileMode.append);
        print('conts');
      } catch (e) {
        print('saving to csv error');
        print(e);
      }
    }
  }

  saveDataToTXT(snapshot_lists, file_name) async {
    const headers = "student_index, score, percentage, out_of, grade";

    try {
      final directory = await getApplicationDocumentsDirectory();
      //print(directory.path);
      final File file = File('${directory.path}/${file_name}.txt');
      await file.writeAsString(headers, mode: FileMode.write);
      print(file.path);
    } catch (e) {
      print(e);
    }
    for (var i = 0; i < snapshot_lists.length; i++) {
      // writeContentsToTxtFile(test_doc_id,
      //     "${rand.nextInt(9999999)}, ${rand.nextInt(200)}, ${rand.nextDouble() * 100}, 200");

      try {
        final directory = await getApplicationDocumentsDirectory();
        final File file = File('${directory.path}/${file_name}.txt');
        await file.writeAsString(
            "\r\n" +
                "${snapshot_lists[i]["student_idx"]}, ${snapshot_lists[i]["score"]}, ${snapshot_lists[i]["percentage"]}, ${snapshot_lists[i]["out_of"]}, ${snapshot_lists[i]["grade"]}",
            mode: FileMode.append);
        print('conts');
      } catch (e) {
        print('saving to txt error');
        print(e);
      }
    }
  }

  shareTxtFile(String file_name) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final _path = '${directory.path}/${file_name}.txt';
      Share.shareFiles([_path], text: 'share data');
    } catch (e) {
      print(e);
    }
  }

  shareCSVFile(String file_name) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final _path = '${directory.path}/${file_name}.csv';
      Share.shareFiles([_path], text: 'share data');
    } catch (e) {
      print(e);
    }
  }

  shareJSONFile(String test_doc_id) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final _path = '${directory.path}/${test_doc_id}.JSON';
      Share.shareFiles([_path], text: 'share data');
    } catch (e) {
      print(e);
    }
  }
}
