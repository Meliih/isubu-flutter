import 'package:flutter/material.dart';
import 'package:isubu_universite/DbHelper.dart';
import 'package:isubu_universite/Faculties.dart';
import 'package:isubu_universite/LoginPage.dart';
import 'package:isubu_universite/PdfViewer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Globals.dart' as globals;
import 'NotificationPage.dart';
import 'package:firebase_storage/firebase_storage.dart';


class NavigationDrawer extends StatefulWidget {
  final notifications;
  const NavigationDrawer({Key? key,  this.notifications}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final storageRef = FirebaseStorage.instance.ref();
    String foodlistUrl = "";
    storageRef.child("yemek.pdf").getDownloadURL().then((value) {
      foodlistUrl = value;
    });
    
    


    final name = globals.username;
    final email = globals.email;
    final image = "https://isparta.edu.tr/foto.aspx?sicil_no=01890";
    setState(() {
      globals.username = name;
      globals.email = email;
      foodlistUrl = foodlistUrl;
    });
    return Drawer(
      child: Material(
          color: Color.fromRGBO(32, 85, 165, 1),
          child: ListView(
            children: <Widget>[
              buildHeader(
                image: image,
                name: name,
                email: email,
                onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginPage(),
                )),
              ),
              Container(
                padding: padding,
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: "Fakülteler",
                      icon: Icons.school,
                      onClicked: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Faculties(),
                          )),
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: "Duyurular",
                      icon: Icons.notifications,
                      onClicked: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationPage(notifications : widget.notifications),
                          )), 
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: "Akademik Takvim",
                      icon: Icons.calendar_month,
                      onClicked: () {
                        DbHelper().academical().then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfViewer(path: value),
                              ));
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      text: "Yemek Listesi",
                      icon: Icons.food_bank,
                      onClicked: () {
                        
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfViewer(path: foodlistUrl),
                              ));
                        
                      },
                      
                    ),
                    const SizedBox(height: 24),
                    Divider(color: Colors.white70),
                    const SizedBox(height: 20),
                    buildMenuItem(
                      text: "Destek",
                      icon: Icons.support,
                    ),
                    const SizedBox(height: 20),
                    buildMenuItem(
                        text: "Çıkış Yap",
                        icon: Icons.logout,
                        onClicked: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          prefs.remove('username');
                          prefs.remove('email');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        }),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  Widget buildHeader({
    required String image,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(image),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
