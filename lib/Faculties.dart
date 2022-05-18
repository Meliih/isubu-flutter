import 'package:flutter/material.dart';
import 'package:isubu_universite/DbHelper.dart';
import 'package:isubu_universite/NavigationDrawer.dart';
import 'package:isubu_universite/auth.dart';

import 'Departments.dart';

class Faculties extends StatefulWidget {
  

  const Faculties({Key? key}) : super(key: key);
  
  @override
  State<Faculties> createState() => _FacultiesState();
}

class _FacultiesState extends State<Faculties> {
  late Future<List<String>> faculties;
  
  @override
  Widget build(BuildContext context) {
    
    faculties = DbHelper().getFaculties();
      // print list element
    Auth().login('melih', '123');
      
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Bölümler'),
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
                    future: faculties,
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => Departments(department: department)));
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
    ),
  );
}

}
