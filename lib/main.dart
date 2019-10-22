import 'package:flutter/material.dart';
import './horror.dart' as horror;
import './pemrograman.dart' as pemrograman;
import './komedi.dart' as komedi;

void main(){
  runApp(new MaterialApp(
   title: "E-Book Que",
   home: new Home(),
  ));
}

class  Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  //create controller untuk tabBar
  TabController controller;

  @override

  void initState(){
    controller = new TabController(vsync: this, length: 3);
    //tambahkan SingleTickerProviderStateMikin pada class _HomeState
    super.initState();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //create appBar
      appBar: new AppBar(
        //warna background
        backgroundColor: Colors.blueGrey,
         //judul
         title: new Text("E-Book Que"),
           //bottom
           bottom: new TabBar(
             controller: controller,
             indicatorColor: Colors.cyanAccent,
             //source code lanjutan
             tabs: <Widget>[
              new Tab(icon: new Icon(Icons.child_care),text: "Komedi",),
              new Tab(icon: new Icon(Icons.beach_access),text: "Pemrograman",),
              new Tab(icon: new Icon(Icons.event_seat),text: "Horror",), 
             ],
        ),
      ),
      body: new TabBarView(
        //controller untuk tab bar
        controller: controller,
        children: <Widget>[
          //kemudian panggil halaman sesuai tab yang sudah dibuat
          new horror.Horror(),
          new pemrograman.Pemrograman(),
          new komedi.Komedi(),
        ],
      ),
    );
  }
}