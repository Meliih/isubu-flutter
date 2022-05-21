import 'package:flutter/material.dart';
import 'NavigationDrawer.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var rowCount = 1;
  List<double> array = [];
  List<TextEditingController> vizenotlari = [TextEditingController()];
  List<TextEditingController> vizeoran = [TextEditingController()];
  var finalnotu = TextEditingController();
  var finaloran = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(32, 85, 165, 1),
        title: Text('Vize - Final Hesaplayıcı'),
      ),
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
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: rowCount,
                  itemBuilder: (context, index) {
                    return buildLine(size, index + 1);
                  },
                ),
                ButtonTheme(
                  minWidth: 20,
                  height: 20,
                  child: RaisedButton(
                    onPressed: () {
                      print(rowCount);
                      print(vizenotlari.length);
                      rowCount--;
                      vizenotlari.removeLast();
                      vizeoran.removeLast();
                      setState(() {
                        print("remove vize");
                      });
                    },
                    color: Color.fromRGBO(32, 85, 165, 0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
                buildfinal(size),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonTheme(
                      minWidth: 50,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          print(rowCount);
                          print(vizenotlari.length);
                          rowCount++;
                          vizenotlari.add(TextEditingController());
                          vizeoran.add(TextEditingController());
                          setState(() {
                            print("vize eklemek için");
                          });
                        },
                        color: Color.fromRGBO(32, 85, 165, 1),
                        child: Text(
                          "Vize Ekle",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    ButtonTheme(
                      minWidth: 50,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          calculate();
                        },
                        color: Color.fromRGBO(32, 85, 165, 1),
                        child: Text(
                          "Hesapla",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: array.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: Text(
                          "Not Ortalamanız = " +
                              array[index].toString() +
                              "\nHarf Notunuz : " +
                              harfaraligi(array[index]),
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.values[4]),
                        )),
                      ],
                    );
                  },
                ),
              ],
            )),
      ),
    );
  }

  Widget buildLine(Size size, int index) {
    return Row(
      children: [
        SizedBox(
          width: size.width * 2 / 14,
        ),
        Container(
          width: size.width * 3 / 28,
          child: Text("Vize $index",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(32, 85, 165, 1))),
        ),
        SizedBox(
          width: 30,
        ),
        Container(
          width: size.width * 2 / 14,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: vizenotlari[index - 1],
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "55",
              hintStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        SizedBox(
          width: size.width * 1 / 14,
        ),
        Container(
          width: size.width * 3 / 28,
          child: Text("Oran",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(32, 85, 165, 1))),
        ),
        SizedBox(
          width: 30,
        ),
        Container(
          width: size.width * 2 / 14,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: vizeoran[index - 1],
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "40",
              hintStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildfinal(Size size) {
    return Row(
      children: [
        SizedBox(
          width: size.width * 2 / 14,
        ),
        Container(
          width: size.width * 3 / 28,
          child: Text("Final",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(32, 85, 165, 1))),
        ),
        SizedBox(
          width: 30,
        ),
        Container(
          width: size.width * 2 / 14,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: finalnotu,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "70",
              hintStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        SizedBox(
          width: size.width * 1 / 14,
        ),
        Container(
          width: size.width * 3 / 28,
          child: Text("Oran",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(32, 85, 165, 1))),
        ),
        SizedBox(
          width: 30,
        ),
        Container(
          width: size.width * 2 / 14,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: finaloran,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "60",
              hintStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void calculate() {
    var agirliklinotortalamasi = 0.0;

    var toplamoran = 0;
    var oran = 0;
    var vizenots;
    var hatakodu = 0;
    if (finaloran.text == "" || finalnotu.text == "") {
      final snackBar = SnackBar(
        content: const Text('Alanlar boş bırakılamaz'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    var finalorann = int.parse(finaloran.text);
    var finalnotuu = int.parse(finalnotu.text);
    // hata kodu 0 ise herşey düzgün
    // hata kodu 1 ise vize oranlarının ve final oranını toplamı 100 olmalı
    // hata kodu 2 ise vize oranlarınından biri 0 -100 arasında değil
    // hata kodu 3 ise final oranı 1- 100 arasında degildir
    // hata kodu 4 ise vize notu 0 - 100 arasında degildir
    for (int i = 0; i < vizenotlari.length; i++) {
      if (vizeoran[i].text == "" || vizenotlari[i].text == "") {
        final snackBar = SnackBar(
          content: const Text('Alanlar boş bırakılamaz'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
      oran = int.parse(vizeoran[i].text);
      vizenots = int.parse(vizenotlari[i].text);
      agirliklinotortalamasi += vizenots * oran / 100;
      toplamoran += oran;

      if (oran <= 0 || oran > 100) {
        hatakodu = 2;
      }
      if (vizenots <= 0 || vizenots > 100) {
        hatakodu = 4;
      }
    }

    if (finalnotuu <= 0 || finalnotuu > 100) {
      final snackBar = SnackBar(
        content: const Text('Final notu 0 - 100 olmalıdır'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (hatakodu == 4) {
      final snackBar = SnackBar(
        content: const Text('Vize notu 0 - 100 olmalıdır'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (hatakodu == 2) {
      final snackBar = SnackBar(
        content: const Text('Vize oranı 0 - 100 olmalıdır'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (toplamoran + finalorann != 100) {
      hatakodu = 1;
      final snackBar = SnackBar(
        content: const Text('Vize ve final oranlarının toplamı 100 olmalıdır'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (hatakodu == 0) {
      agirliklinotortalamasi += finalnotuu * finalorann / 100;
      array.clear();
      array.add(agirliklinotortalamasi);
      setState(() {
        print("hata yok");
      });
    }
  }

  String harfaraligi(double number) {
    if (number >= 88 && number <= 100) {
      return "AA";
    } else if (number >= 80 && number <= 87) {
      return "BA";
    } else if (number >= 73 && number <= 79) {
      return "BB";
    } else if (number >= 66 && number <= 72) {
      return "CB";
    } else if (number >= 60 && number <= 65) {
      return "CC";
    } else if (number >= 55 && number <= 59) {
      return "DC";
    } else if (number >= 50 && number <= 54) {
      return "DD";
    } else if (number >= 0 && number <= 49) {
      return "FF";
    }
    return "";
  }
}
