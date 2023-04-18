import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import 'package:async/async.dart';
import 'dart:convert';

var request = Uri.parse("https://api.hgbrasil.com/finance?format=json&key=d73f163f");
void main() async{

  http.Response response = await http.get(request);
  var x = json.decode(response.body)["results"]["currencies"]["USD"];
  print(x);
  runApp(MaterialApp(
    home: Container(),
  ));
}
