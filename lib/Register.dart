import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                  height: 75,
                ),
                Text(
                  "*Parola kısmı en az 8 karakterden oluşmalıdır.",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "*Kullanıcı adınıza ögrenci numaranınız giriniz.",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Giriş Bilgilerinizi Oluşturunuz",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 30,
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
                  height: 15,
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
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: Color.fromRGBO(32, 85, 165, 1),
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
                SizedBox(
                  height: 15,
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
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Color.fromRGBO(32, 85, 165, 1),
                          ),
                          border: InputBorder.none,
                          hintText: "Email",
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
                  height: 30,
                ),
                ButtonTheme(
                  minWidth: size.width * 5 / 14,
                  height: 50,
                  child: RaisedButton(
                    color: Color.fromRGBO(32, 85, 165, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Kayıt Ol",
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
}
