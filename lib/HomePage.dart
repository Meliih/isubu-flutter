import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isubu_universite/DbHelper.dart';
import 'package:isubu_universite/Departments.dart';
import 'package:isubu_universite/Faculties.dart';
import 'package:isubu_universite/NavigationDrawer.dart';
import 'package:isubu_universite/NotificationPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Notifications>> notification;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );
    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          // LocalNotificationService.display(message);

        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    notification = DbHelper().getNotification();
    return WillPopScope(
      onWillPop: () { SystemNavigator.pop(); return Future.value(false);},
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('ISUBU ÖĞRENCİ PLATFORMU'),
          backgroundColor: Color.fromRGBO(32, 85, 165, 1),
        ),
        drawer: NavigationDrawer(notifications: notification,),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage( notifications: notification,)));
                    },)
                    
                  ]),
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
      margin: EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Color.fromRGBO(42, 115, 186, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                notification.faculty,
                style: TextStyle(
                    fontSize: 16,
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
