import 'package:flutter/material.dart';
import 'dart:math';

class StudentsSummary extends StatelessWidget {
  StudentsSummary({Key? key}) : super(key: key);

  List<Map> _products = List.generate(30, (i) {
    return {"id": i, "name": "Product $i", "price": Random().nextInt(200) + 1};
  });

  // int _currentSortColumn = 0;
  // bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: 20,
        itemBuilder: ((context, index) {
          return ListTile(
            title: Text('Student $index'),
            onTap: () {
              Navigator.pushNamed(context, 'individual');
            },
          );
        }));
  }
}
