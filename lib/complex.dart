import 'dart:convert';

import 'package:apicall/model/comModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplexModel extends StatefulWidget {
  const ComplexModel({super.key});

  @override
  State<ComplexModel> createState() => _ComplexModelState();
}

class _ComplexModelState extends State<ComplexModel> {
  Future<ComModel> getComplexapi() async {
    final response = await http.get(
        Uri.parse("https://webhook.site/cf656ddd-5fe6-4aff-8e57-85588011eef6"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return ComModel.fromJson(data as Map<String, dynamic>);
    } else {
      return ComModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COmplex JSON API Call"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getComplexapi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(23.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(snapshot.data!.data![index].shop!.name
                                  .toString()),
                              subtitle: Text(snapshot
                                  .data!.data![index].shop!.shopemail
                                  .toString()),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(snapshot
                                    .data!.data![index].shop!.image
                                    .toString()),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width * 1,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot
                                      .data!.data![index].images!.length,
                                  itemBuilder: (context, position) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 17),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(17),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(snapshot
                                                .data!
                                                .data![index]
                                                .images![position]
                                                .url
                                                .toString()),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            Icon(snapshot.data!.data![index].inWishlist! == true
                                ? Icons.favorite
                                : Icons.favorite_border_outlined),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Text("loading");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
