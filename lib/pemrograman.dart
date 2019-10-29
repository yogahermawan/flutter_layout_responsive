import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Pemrograman extends StatelessWidget {

  Future<List<User>> _getUsers() async{

    var data = await http.get("https://raw.githubusercontent.com/bvaughn/infinite-list-reflow-examples/master/books.json");
    var jsonData = json.decode(data.body);
    List<User> users = [];
    for (var it in jsonData) {
      User user = User(it["indek"], it["thumbnailUrl"], it["title"], it["isbn"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }


  @override
  Widget build(BuildContext context) {
    return new Container(
      child: FutureBuilder(
        future: _getUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: Text("Mohon bersabar..."),
              ),
            );
          }
          else{
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      snapshot.data[index].thumbnailUrl
                    ),
                  ),
                  title: Text(snapshot.data[index].title),
                  subtitle: Text(snapshot.data[index].isbn),
                  onTap: (){
                    Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => Detail(snapshot.data[index])));
                  },
                );
              },
            );
          }
        },
      )
    );
  }
}

class Detail extends StatelessWidget {
  
  final User user;
  Detail(this.user);
  gridPhone(){
    return Scaffold(
      body: Text('Tampilan untuk layar handphone'),
    );
  }

  gridTablet(){
    return Scaffold(
      body: Text('Tampilan untuk layar handphone'),
    );
  }
  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool layarMobile = shortestSide < 600.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.title),
      ),
      body: layarMobile ? gridPhone() : gridTablet());
  }
}

class User {
  final int indek;
  final String title;
  final String thumbnailUrl;
  final String isbn;

  User(this.indek, this.thumbnailUrl, this.title, this.isbn);
}
