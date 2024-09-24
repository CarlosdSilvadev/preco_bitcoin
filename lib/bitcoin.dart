import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _valor = "0";

  void _recuperarPreco() async {
    String url = "https://blockchain.info/ticker";
    Uri uri = Uri.parse(url); // Correção: Converte string para Uri

    http.Response response = await http.get(uri);

    Map<String, dynamic> retorno = json.decode(response.body);

    setState(() {
      _valor = retorno["BRL"]["buy"].toString();
    });

    print("Resultado : " + retorno["BRL"]["buy"].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: 300,
                height: 300,
                child: Image.asset("img/bitcoin.png"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Text("R\$ $_valor"),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                  onPressed: _recuperarPreco,
                  child: Text(
                    "Atualizar",
                    style: TextStyle(
                        color: Color.fromARGB(255, 17, 17, 17), fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9419))),
            )
          ],
        ),
      ),
    );
  }
}
