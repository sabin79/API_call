import 'dart:convert';

import 'package:apicall/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Usermodel extends StatefulWidget {
  const Usermodel({super.key});

  @override
  State<Usermodel> createState() => _UsermodelState();
}

class _UsermodelState extends State<Usermodel> {
  List<UserModel> Userlist = [];
  Future<List<UserModel>> GetuserApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        Userlist.add(UserModel.fromJson(i as Map<String, dynamic>));
      }
      return Userlist;
    } else {
      return Userlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User API call"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: GetuserApi(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                    itemCount: Userlist.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Rowuse(
                                  title: "Name",
                                  value: snapshot.data![index].name.toString()),
                              Rowuse(
                                  title: " User Name",
                                  value: snapshot.data![index].username
                                      .toString()),
                              Rowuse(
                                  title: "Email",
                                  value:
                                      snapshot.data![index].email.toString()),
                              Rowuse(
                                  title: "Address",
                                  value: snapshot.data![index].address!.city
                                          .toString() +
                                      snapshot.data![index].address!.geo!.lat
                                          .toString()),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
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
      padding: const EdgeInsets.all(4.0),
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
