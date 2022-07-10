import 'package:flutter/material.dart';

class addTestWidget extends StatelessWidget {
  const addTestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: MaterialButton(
                  onPressed: () {},
                  child: Text(
                    'Add Test',
                    style: TextStyle(color: Colors.black),
                  ))),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ));
  }
}
