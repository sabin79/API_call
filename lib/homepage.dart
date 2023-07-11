import 'dart:convert';

import 'package:apicall/model/jsonmode.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<model> postlist = [];
  Future<List<model>> getpostApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        postlist.add(model.fromJson(i as Map<String, dynamic>));
      }
      return postlist;
    } else {
      return postlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API call"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getpostApi(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("loading");
                } else {
                  return ListView.builder(
                      itemCount: postlist.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Title:',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(postlist[index].title.toString()),
                                SizedBox(
                                  height: 07,
                                ),
                                Text('title:\n' +
                                    postlist[index].title.toString()),
                                SizedBox(
                                  height: 07,
                                ),
                                Text('description: \n' +
                                    postlist[index].body.toString()),
                              ],
                            ),
                          ),
                        );
                      });
                }
              }),
            ),
          )
        ],
      ),
    );
  }
}
