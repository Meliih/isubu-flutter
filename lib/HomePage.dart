import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isubu_universite/DbHelper.dart';
import 'package:isubu_universite/Departments.dart';
import 'package:isubu_universite/Faculties.dart';
import 'package:isubu_universite/NavigationDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<String>> faculties;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    faculties = DbHelper().getFaculties();
    return WillPopScope(
      onWillPop: () { SystemNavigator.pop(); return Future.value(false);},
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('ISUBU ÖĞRENCİ PLATFORMU'),
          backgroundColor: Color.fromRGBO(32, 85, 165, 1),
        ),
        drawer: NavigationDrawer(),
        body: SingleChildScrollView(
          child: Container(
              height: size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: new AssetImage("assets/background.jpeg"),
                fit: BoxFit.fill,
              )),
              child: Column(
                children: [
                 
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 235,
                    child: Image.asset("assets/logo2.png"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  
                  
                  
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("Duyurular", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    GestureDetector(child: Text('Tümünü Göster', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, ),), onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Faculties()));
                    },)
                    
                  ]),
                  Expanded(
                    child: Container(
                      
                      child: FutureBuilder<List<String>>(
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
                            }),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
  Widget buildLine(BuildContext context, String department, Size size) {
  
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Departments(department: department)));
    },
    child: Container(
      height: 40,
     
      // width: size.width,
      margin: EdgeInsets.all(5),
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
