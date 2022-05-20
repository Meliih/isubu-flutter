import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isubu_universite/DbHelper.dart';
import 'package:isubu_universite/auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isHidden = true;
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
                        controller: usernameController,
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
                        controller: passwordController,
                        obscureText: isHidden,
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
                        controller: emailController,
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
                    onPressed: () async {
                      setState(() {});
                      if (!isEmpty() && validator()) {
                        if (await Auth().signup(usernameController.text,
                            passwordController.text, emailController.text)) {
                              Navigator.pop(context);
                            }
                        else{
                          showAlert("Bu kullanıcı adı zaten kullanılıyor.");
                        }
                      }
                    },
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

  bool isEmpty() {
    if (usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        emailController.text.isEmpty) {
      showAlert("Boş alan bırakmayınız.");
      return true;
    }
    return false;
  }

  bool validator() {
    String nums = "0123456789";
    for (int i = 0; i < usernameController.text.length; i++) {
      bool correct = false;
      for (int j = 0; j < nums.length; j++) {
        if (usernameController.text[i] == nums[j]) {
          correct = true;
        }
      }
      if (!correct) {
        showAlert("Kullanıcı adınız yalnızca sayılardan oluşabilir");
        return false;
      }
    }
    // username includes only numbers
    if (passwordController.text.length < 8) {
      showAlert("Parolanız en az 8 karakter olmalıdır.");
      return false;
    }

    bool includeat = false;
    bool includeDot = false;
    for (int i = 0; i < emailController.text.length; i++) {
      if (emailController.text[i] == '@') {
        includeat = true;
      } else if (emailController.text[i] == '.') {
        includeDot = true;
      }
    }
    if (!includeat || !includeDot) {
      showAlert("Email adresinizi doğru girdiğinizden emin olunuz.");
      return false;
    }

    return true;
  }

  void showAlert(String alert) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hata"),
          content: Text(alert),
          actions: [
            FlatButton(
              child: Text("Tamam"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void togglePasswordVisibilty() => setState(() => isHidden = !isHidden);
}
