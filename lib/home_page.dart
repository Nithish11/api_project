import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //varibale,method declare from

  List data = [];
  Future<void> fetchdata() async {
    final res = await http.get(Uri.parse("https://reqres.in/api/users?page=1"));
    print("API method");
    print(res.statusCode);
    print(res.body.toString());

    setState(() {
      data = json.decode(res.body)['data'];
    });
  }

  //end

  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter Api",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  data += [
                    {
                      "id": data.length + 1,
                      "email": "nithishkumar@mail.in",
                      "first_name": "Nithish",
                      "last_name": "kumar",
                      "avatar": "https://reqres.in/img/faces/7-image.jpg"
                    }
                  ];
                });
              },
              icon: Icon(Icons.add_outlined)),
        ],
        centerTitle: true,
        leading: Icon(Icons.menu),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(data[index]['avatar']),
              radius: 35,
            ),
            trailing: IconButton(
                onPressed: () {
                  // print("delete button");
                  setState(() {
                    data.removeWhere((entry)=> entry["id"]==data[index]['id']);
                  });
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
            title: Text(
              data[index]['first_name'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: Text(
              data[index]['email'],
              style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
            ),
          );
        },
      ),
    );
  }
}
