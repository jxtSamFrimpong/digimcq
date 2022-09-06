import 'package:flutter/material.dart';
import 'apirelearnmodels.dart';
import 'package:http/http.dart' as http;

class ApiRelearn extends StatefulWidget {
  @override
  State<ApiRelearn> createState() => _ApiRelearnState();
}

class _ApiRelearnState extends State<ApiRelearn> {
  // const ApiRelearn({Key? key}) : super(key: key);
  late Welcome _welcome;

  TextEditingController nameController = TextEditingController();

  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('http post'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter name'),
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter job'),
                controller: jobController,
              ),
              ElevatedButton(
                onPressed: () async {
                  String name = nameController.text;
                  String job = jobController.text;
                  Welcome data = await submitData(name, job);
                  print(data.job.toString());
                  setState(() {
                    _welcome = data;
                  });
                  print(_welcome.job.toString());
                },
                child: Text('submit'),
              ),
              // FutureBuilder(
              //   future: submitData(nameController.text, jobController.text),
              //   builder: ((context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.none) {
              //       return Container();
              //     }
              //     if (snapshot.connectionState == ConnectionState.done) {
              //       if (snapshot.hasError) {
              //         return Container(
              //           child: Center(
              //             child: Text('error'),
              //           ),
              //         );
              //       } else if (snapshot.hasData) {
              //         return Container(
              //             child: Text(
              //           snapshot.data
              //         ));
              //       }
              //     }
              //     return Container(
              //       child: Text('default'),
              //     );
              //   }),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

Future<Welcome> submitData(String name, String job) async {
  var response = await http.post(
    Uri.https('reqres.in', 'api/users'),
    body: {"name": name, "job": job},
  );
  var data = response.body;
  print(data);

  if (response.statusCode == 201) {
    String responseString = response.body;
    return welcomeFromJson(responseString);
  } else {
    return welcomeFromJson('{"error":"error"}');
  }
}

// Future welcomeDataFuture(welcome) async {
//   if (welcome == null) {
//     return '';
//   } else {
//     return welcome;
//   }
// }
