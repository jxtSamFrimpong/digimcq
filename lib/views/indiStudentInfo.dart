import 'package:flutter/material.dart';

class IndividualStudentInfo extends StatelessWidget {
  const IndividualStudentInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(child: Text('Student ID')),
          Container(
            height: 200,
            width: 200,
            child: Text('image place holder'),
            color: Colors.redAccent,
          )
        ]),
      ),
    );
  }
}
