import 'package:flutter/material.dart';
import 'package:isubu_universite/TeacherPage.dart';

import 'DbHelper.dart';
import 'NavigationDrawer.dart';

class Departments extends StatefulWidget {
  final String department;
  const Departments({ Key? key , required this.department}) : super(key: key);

  @override
  State<Departments> createState() => _DepartmentsState();
}

class _DepartmentsState extends State<Departments> {
  late Future<List<String>> departments;

  @override
  Widget build(BuildContext context) {
    departments = DbHelper().getDepartments(widget.department);
      // print list element
      
    //widget.department;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.department),
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
        child: 
                FutureBuilder<List<String>>(
                    future: departments,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              
                              return buildLine(context, snapshot.data![index], size);
                            });
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    })
      ),
    );
  }

  Widget buildLine(BuildContext context, String department, Size size) {
  
  return GestureDetector(
    onTap: () {
      
    },
    child: Container(
      height: 80,
     
      // width: size.width,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(32, 85, 165, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  department,
                  style: TextStyle(
                      fontSize: 16,
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
          Divider(
            color: Colors.white,
            thickness: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: size.width * 3 / 11,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 162, 255),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Center(
                    child: Text(
                      "Duyurular",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherPage(department: widget.department + '/' +  department)));},
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 162, 255),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  width: size.width * 3 / 11,
                  height: 40,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Center(
                    child: Text(
                      "Hocalar",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
        ],
      ),
    ),
  );
}
}