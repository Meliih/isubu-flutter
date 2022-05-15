import 'package:flutter/material.dart';
import 'package:isubu_universite/DbHelper.dart';
import 'package:isubu_universite/NavigationDrawer.dart';

class Faculties extends StatefulWidget {
  const Faculties({Key? key}) : super(key: key);

  @override
  State<Faculties> createState() => _FacultiesState();
}

class _FacultiesState extends State<Faculties> {
  List<String> departments = [
    "Büyükkutlu Uygulamalı Fakültesi",
    "Eğirdir Su Fakültesi",
    "İşletme Fakültesi",
    "Orman Fakültesi",
    "Teknoloji Fakültesi",
    "Turizm Fakültesi"
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Fakülteler'),
        backgroundColor: Color.fromRGBO(32, 85, 165, 1),
      ),
      drawer: NavigationDrawer(),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: new AssetImage("assets/background.jpeg"),
          fit: BoxFit.fill,
        )),
        child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: departments.length,
                  itemBuilder: (context, index) {
                    return buildLine(context, departments[index], size);
                  },
                ),
      ),
    );
  }

  Widget buildLine(BuildContext context, String department, Size size) {
  
  return GestureDetector(
    onTap: () {
      DbHelper().readData();
    },
    child: Container(
      height: 60,
     
      // width: size.width,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(32, 85, 165, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              department,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

}
