import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class NoModel extends StatefulWidget {
  const NoModel({super.key});

  @override
  State<NoModel> createState() => _NoModelState();
}

class _NoModelState extends State<NoModel> {
  var data;
  Future<void> getUserApi() async {
    final Response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    data = jsonDecode(Response.body.toString());
    if (Response.statusCode == 200) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("No model API Call"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 29, 230, 248),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("waiting");
                } else {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(children: [
                            Rowuse(
                                title: 'name',
                                value: data[index]['name'].toString()),
                            Rowuse(
                                title: 'username',
                                value: data[index]['username'].toString()),
                          ]),
                        );
                      });
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class Rowuse extends StatelessWidget {
  String title, value;
  Rowuse({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
