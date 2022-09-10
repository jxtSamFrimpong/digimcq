import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../providerclasses/providerclasses.dart' as prov;

getCsv(uid, test_doc_id, c_code) async {

    List<List<dynamic>> rows = List<List<dynamic>>();
    
    var cloud = await Firestore.instance
        .collection(uid)
        .document(test_doc_id)
        .get();
        
    rows.add([
      "student_index",
      "marks_got",
      "percentage",
      "course_code"
    ]);
    
    if (cloud.data != null) {
      for (int i = 0; i < cloud.data["collected"].length; i++) {
        List<dynamic> row = List<dynamic>();
        row.add(cloud.data["collected"][i]["name"]);
        row.add(cloud.data["collected"][i]["gender"]);
        row.add(cloud.data["collected"][i]["phone"]);
        row.add(cloud.data["collected"][i]["email"]);
        row.add(cloud.data["collected"][i]["age_bracket"]);
        row.add(cloud.data["collected"][i]["area"]);
        row.add(cloud.data["collected"][i]["assembly"]);
        row.add(cloud.data["collected"][i]["meal_ticket"]);
        rows.add(row);
      }

      File f = await _localFile;
      
      String csv = const ListToCsvConverter().convert(rows);
      f.writeAsString(csv);
    }
  }