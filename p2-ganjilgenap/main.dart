import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CekBilangan());
  }
}

class CekBilangan extends StatefulWidget {
  const CekBilangan({super.key});

  @override
  _CekBilanganState createState() => _CekBilanganState();
}

class _CekBilanganState extends State<CekBilangan> {
  final TextEditingController _controller = TextEditingController();

  String _hasil = '';
  Color _warna = Colors.black;
  String mode = "GanjilGenap";

  List<String> deret = [];

  // ✅ Fungsi Ganjil Genap
  String cekGanjilGenap(int angka) {
    return angka % 2 == 0 ? "Genap" : "Ganjil";
  }

  // ✅ Fungsi FizzBuzz
  String fizzBuzz(int n) {
    if (n % 3 == 0 && n % 5 == 0) return "FizzBuzz";
    if (n % 3 == 0) return "Fizz";
    if (n % 5 == 0) return "Buzz";
    return n.toString();
  }

  // ✅ Buat deret FizzBuzz
  void buatDeret() {
    deret.clear();
    for (int i = 1; i <= 20; i++) {
      deret.add(fizzBuzz(i));
    }
  }

  // ✅ Proses tombol
  void proses() {
    setState(() {
      if (_controller.text.isEmpty) {
        _hasil = "Input tidak boleh kosong!";
        _warna = Colors.red;
        return;
      }

      int? angka = int.tryParse(_controller.text);

      if (angka == null) {
        _hasil = "Masukkan angka yang valid!";
        _warna = Colors.red;
      } else {
        if (mode == "GanjilGenap") {
          _hasil = cekGanjilGenap(angka);
          deret.clear(); // kosongkan list
        } else {
          _hasil = fizzBuzz(angka);
          buatDeret(); // tampilkan deret
        }
        _warna = Colors.green;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ganjil Genap & FizzBuzz")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Masukkan angka"),
            ),

            SizedBox(height: 10),

            // ✅ Dropdown Mode
            DropdownButton<String>(
              value: mode,
              items: [
                DropdownMenuItem(
                  value: "GanjilGenap",
                  child: Text("Ganjil Genap"),
                ),
                DropdownMenuItem(value: "FizzBuzz", child: Text("FizzBuzz")),
              ],
              onChanged: (value) {
                setState(() {
                  mode = value!;
                });
              },
            ),

            SizedBox(height: 10),

            ElevatedButton(onPressed: proses, child: Text("Cek")),

            SizedBox(height: 20),

            Text(_hasil, style: TextStyle(fontSize: 20, color: _warna)),

            SizedBox(height: 20),

            // ✅ LISTVIEW DERET FIZZBUZZ
            if (mode == "FizzBuzz" && deret.isNotEmpty)
              Expanded(
                child: ListView.separated(
                  itemCount: deret.length,
                  separatorBuilder: (_, __) => Divider(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("Index ${index + 1}: ${deret[index]}"),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
