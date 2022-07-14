import 'package:flutter/material.dart';

class addTestWidget extends StatelessWidget {
  addTestWidget({Key? key}) : super(key: key);
  TextEditingController addtestcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          // onChanged: (e){

          // },
          controller: addtestcontroller,
        ),
        MaterialButton(
          onPressed: () {
            //TODO do some checks add test to firebase
            addtestcontroller.clear();
          },
          child: Center(child: Text('+ ADD')),
        )
      ],
    );
  }
}
