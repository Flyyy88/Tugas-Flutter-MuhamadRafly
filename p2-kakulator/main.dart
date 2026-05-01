import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KalkulatorFull(),
    );
  }
}

class KalkulatorFull extends StatefulWidget {
  @override
  _KalkulatorFullState createState() => _KalkulatorFullState();
}

class _KalkulatorFullState extends State<KalkulatorFull> {
  String display = "0";
  String history = "";

  double angka1 = 0;
  String operator = "";
  bool resetDisplay = false;

  // 🔥 FORMAT ANGKA (hapus .0)
  String formatAngka(double angka) {
    if (angka == angka.toInt()) {
      return angka.toInt().toString();
    } else {
      return angka.toString();
    }
  }

  void tekan(String value) {
    setState(() {
      if (value == "C") {
        display = "0";
        history = "";
        angka1 = 0;
        operator = "";
        return;
      }

      // toggle negatif
      if (value == "+/-") {
        if (display != "0") {
          if (display.startsWith("-")) {
            display = display.substring(1);
          } else {
            display = "-$display";
          }
        }
        return;
      }

      // persen
      if (value == "%") {
        double val = double.parse(display) / 100;
        display = formatAngka(val);
        return;
      }

      // operator
      if (["+", "-", "×", "÷"].contains(value)) {
        angka1 = double.parse(display);
        operator = value;
        history = "${formatAngka(angka1)} $operator";
        resetDisplay = true;
        return;
      }

      // sama dengan
      if (value == "=") {
        double angka2 = double.parse(display);
        double hasil = 0;

        switch (operator) {
          case "+":
            hasil = angka1 + angka2;
            break;
          case "-":
            hasil = angka1 - angka2;
            break;
          case "×":
            hasil = angka1 * angka2;
            break;
          case "÷":
            if (angka2 == 0) {
              display = "Error";
              history = "Tidak bisa bagi 0";
              return;
            }
            hasil = angka1 / angka2;
            break;
        }

        history = "${formatAngka(angka1)} $operator ${formatAngka(angka2)}";
        display = formatAngka(hasil);

        operator = "";
        return;
      }

      // titik desimal
      if (value == ".") {
        if (display.contains(".")) return;
        display += ".";
        return;
      }

      // angka
      if (resetDisplay) {
        display = value;
        resetDisplay = false;
      } else {
        display = display == "0" ? value : display + value;
      }
    });
  }

  Widget tombol(
    String text, {
    Color bg = Colors.white,
    Color fg = Colors.black,
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: () => tekan(text),
        child: Container(
          margin: EdgeInsets.all(6),
          height: 70,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: fg,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // 🔷 DISPLAY
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      history,
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      display,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 🔷 BUTTON AREA
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      tombol("C", bg: Colors.red, fg: Colors.white),
                      tombol("+/-"),
                      tombol("%"),
                      tombol("÷", bg: Colors.orange, fg: Colors.white),
                    ],
                  ),
                  Row(
                    children: [
                      tombol("7"),
                      tombol("8"),
                      tombol("9"),
                      tombol("×", bg: Colors.orange, fg: Colors.white),
                    ],
                  ),
                  Row(
                    children: [
                      tombol("4"),
                      tombol("5"),
                      tombol("6"),
                      tombol("-", bg: Colors.orange, fg: Colors.white),
                    ],
                  ),
                  Row(
                    children: [
                      tombol("1"),
                      tombol("2"),
                      tombol("3"),
                      tombol("+", bg: Colors.orange, fg: Colors.white),
                    ],
                  ),
                  Row(
                    children: [
                      tombol("0", flex: 2), // 🔥 tombol panjang
                      tombol("."),
                      tombol("=", bg: Colors.green, fg: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
