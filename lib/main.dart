import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import 'dart:async';
import 'dart:convert';

var request = Uri.parse("https://api.hgbrasil.com/finance?format=json&key=d73f163f");
void main() async{
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.green,
      primaryColor: Colors.white
    ),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double dolar = 0.0;
  double euro = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return message("Carregando dados...");
            default:
              if(snapshot.hasError) {
                return message("Erro ao carregar os dados");
              } else {
                dolar = snapshot.data?["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data?["results"]["currencies"]["EUR"]["buy"];
                
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                    Icon(Icons.monetization_on, size: 150, color: Colors.green,),
                  textField("Reais", "R\$"),
                  Divider(),
                  textField("Dolar", "US"),
                  Divider(),
                  textField("Euro", "&"),
                  ]),
                );
              }
          }
        }),
    );
  }
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

Center message(String text) {
return Center(
          child: Text(text, style: TextStyle(color: Colors.green, fontSize: 25),
          textAlign: TextAlign.center),
        );
}

TextField textField(String text, String prefixText) {
  return TextField(
    decoration: InputDecoration(
      labelText: text,
      labelStyle: TextStyle(color: Colors.green),
      border: OutlineInputBorder(),
      prefixText: prefixText
    ),
    style: TextStyle(color: Colors.green, fontSize: 25),
  );
}