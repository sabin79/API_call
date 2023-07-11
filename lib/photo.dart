import 'dart:convert';
import 'package:apicall/model/photojson.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotoApi extends StatefulWidget {
  const PhotoApi({super.key});

  @override
  State<PhotoApi> createState() => _PhotoApiState();
}

class _PhotoApiState extends State<PhotoApi> {
  List<Photos> PhotoList = [];

  Future<List<Photos>> getphoto() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        PhotoList.add(Photos.fromJson(i as Map<String, dynamic>));
      }
      return PhotoList;
    } else {
      return PhotoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo API call "),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getphoto(),
              builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                return ListView.builder(
                    itemCount: PhotoList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              snapshot.data![index].url.toString()),
                        ),
                        subtitle: Text(snapshot.data![index].title.toString()),
                        title: Text(
                            'Notes id :' + snapshot.data![index].id.toString()),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class Photos {
//   String title, url;
//   int id;
//   Photos({required this.title, required this.url, required this.id});
//   factory Photos.fromJson(Map<String, dynamic> json) {
//     return Photos(
//       title: json['title'],
//       url: json['url'],
//       id: json['id'],
//     );
//   }
// }
