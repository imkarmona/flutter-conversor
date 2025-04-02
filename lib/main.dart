import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(ConversorApp());
}

class ConversorApp extends StatelessWidget {
  var txtReais = TextEditingController();
  var txtDolares = TextEditingController();

  void converter() async {
    var url = 'https://economia.awesomeapi.com.br/json/last/USD-BRL';

    var response = await http.get(Uri.parse(url));

    var data = json.decode(response.body);

    double cotacao = double.parse(data['USDBRL']['bid']);

    double reais = double.parse(txtReais.text);

    double resultado = reais / cotacao;
    txtDolares.text = resultado.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('Conversor', style: TextStyle(color: Colors.white)),
        ),
        body: Container(
          margin: EdgeInsets.all(25),
          child: Column(
            spacing: 20,
            children: [
              TextField(
                controller: txtReais,
                decoration: InputDecoration(
                  labelText: 'Reais',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              TextField(
                controller: txtDolares,
                decoration: InputDecoration(
                  labelText: 'Dólares',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: converter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.all(20),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Converter', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
