import 'package:flutter/material.dart';
import 'package:isubu_universite/Faculties.dart';
import 'package:isubu_universite/HomePage.dart';
import 'package:isubu_universite/Register.dart';
import 'package:isubu_universite/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Globals.dart' as globals;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var unforget = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Session();
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 5, top: 5),
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(32, 85, 165, 1),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                            )),
                        child: Text(
                          "Misafir Giriş/Kayıt",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 275,
                  child: Image.asset("assets/logo2.png"),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "\"EĞİTİM, KÜLTÜR BE BİLGİ AYDINLIĞA AÇILAN EN GENİŞ PENCEREDİR.\"",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        width: 100,
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 5, top: 5),
                        child: Image.asset("assets/imza.png")),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 3 / 14,
                    ),
                    Container(
                      width: size.width * 8 / 14,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Color.fromRGBO(32, 85, 165, 1),
                          ),
                          border: InputBorder.none,
                          hintText: "Kullanıcı Adı",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 3 / 14,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 3 / 14,
                    ),
                    Container(
                      width: size.width * 8 / 14,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        obscureText: isHidden,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: Color.fromRGBO(32, 85, 165, 1),
                          ),
                          suffixIcon: IconButton(
                            icon: isHidden
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: togglePasswordVisibilty,
                          ),
                          border: InputBorder.none,
                          hintText: "Parola",
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 3 / 14,
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 4 / 14,
                    ),
                    Checkbox(
                        value: unforget,
                        onChanged: (bool? value) {
                          setState(() {
                            unforget = value!;
                          });
                        }),
                    Text("Beni Hatırla"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonTheme(
                  minWidth: size.width * 5 / 14,
                  height: 50,
                  child: RaisedButton(
                    color: Color.fromRGBO(32, 85, 165, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onPressed: () {
                      setState(() {});
                      Auth()
                          .login(_usernameController.text,
                              _passwordController.text)
                          .then((value) {
                        if (value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        } else {
                          final snackBar = SnackBar(
                            content: const Text('Başarısız'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      });
                    },
                    child: Text(
                      "Giriş Yap",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Session() async {
    setState(() {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? email = prefs.getString('email');

    if (username != null && email != null) {
      globals.username = username;
      globals.email = email;

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  void togglePasswordVisibilty() => setState(() => isHidden = !isHidden);
}
