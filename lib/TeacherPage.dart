import 'package:flutter/material.dart';

import 'DbHelper.dart';
import 'NavigationDrawer.dart';

class TeacherPage extends StatefulWidget {
  final department;
  const TeacherPage({Key? key, required this.department}) : super(key: key);

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  late Future<List<Teacher>> teachers;
  @override
  Widget build(BuildContext context) {
    teachers = DbHelper().getTeachers(widget.department);
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
          child: FutureBuilder<List<Teacher>>(
              future: teachers,
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
              })),
    );
  }

  Widget buildLine(BuildContext context, Teacher teacher, Size size) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 100,

        // width: size.width,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromRGBO(32, 85, 165, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                child: Text(
                  teacher.name,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Text(
                    teacher.email.replaceAll(' ', ''),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Text(
                    teacher.phone.replaceAll(' ', ''),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
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
