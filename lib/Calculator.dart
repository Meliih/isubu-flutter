import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var rowCount = 1;
  List<Widget> array = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Calculator'),
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
                buildfinal(size),
                ButtonTheme(
                  minWidth: 50,
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      print(rowCount);
                      rowCount++;
                      setState(() {});
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
              ],
            )),
      ),
    );
  }

  Widget buildLine(Size size, int index) {
    return Row(
      children: [
        SizedBox(
          width: size.width * 1 / 14,
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
        ButtonTheme(
          minWidth: 20,
          height: 20,
          child: RaisedButton(
            onPressed: () {
              print(rowCount);
              rowCount--;
              setState(() {});
            },
            color: Color.fromRGBO(32, 85, 165, 0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
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
              hintText: "Final Notu",
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
    );
  }
}
