import 'package:flutter/material.dart';
import '../views/microwidgets/appBarWidget.dart';
import '../views/microwidgets/listOfCreatedTests.dart';
import 'microwidgets/addTestMicro.dart';

class CreateTestPage extends StatelessWidget {
  const CreateTestPage();

  @override
  Widget build(BuildContext context) {
    return Column(
        //scrollDirection: Axis.vertical,
        //shrinkWrap: true,
        children: [
          AppBarWidget(),
          Expanded(child: listOfCreatedTests()),
          addTestWidget()
          // ,
        ]);
  }
}
