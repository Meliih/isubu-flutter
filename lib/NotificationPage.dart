import 'package:flutter/material.dart';

import 'DbHelper.dart';
import 'NavigationDrawer.dart';

class NotificationPage extends StatefulWidget {
  final notifications;
  const NotificationPage({ Key? key , required this.notifications}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<Notifications>> notification;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    notification = widget.notifications;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Duyurular'),
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

                Expanded(
                  child: Container(
                    
                    child: FutureBuilder<List<Notifications>>(
                          future: notification,
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
    );
  }

  Widget buildLine(BuildContext context, Notifications notification, Size size) {
  
  return GestureDetector(
    onTap: () {
      
    },
    child: Container(
      height: 150,
     
      // width: size.width,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(42, 115, 186, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                notification.faculty,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
            ),
          ),
          Divider(
            thickness: 2,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                notification.head,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 90,
            margin: EdgeInsets.only(left: 10, right: 10),
            child: SingleChildScrollView(
              child: Text(
                notification.body,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
            ),
          ),
          
        ],

      ),
    ),
  );
}
}