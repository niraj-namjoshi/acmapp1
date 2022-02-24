import 'dart:io';

import 'package:app1/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart'as http;
import 'dart:convert';
void main() async{
  List curr = await getCurrencies();
  print(curr);
  runApp(new  MyApp(curr));
}

class MyApp extends StatelessWidget {
   final  List _curr;
  MyApp(this._curr);
  @override
  Widget build(BuildContext context) {
    
    return new MaterialApp(
      theme: new ThemeData(
         primarySwatch: Colors.deepPurple
      ),
      home: new HomePage(_curr),
    );
  }
  }


Future<List>getCurrencies() async {
    var queryParameters = { 'start': '1', 'limit': '5000', 'convert': 'USD', };
    String cryptoUrl = "pro-api.coinmarketcap.com"; 
    var uri = Uri.https(cryptoUrl,"/v1/cryptocurrency/listings/latest",queryParameters); 
    http.Response response = await http.get(uri, headers: {HttpHeaders.ACCEPT:"application/json","X-CMC_PRO_API_KEY":"02661abe-53d8-499c-86d9-376068f429a7"} );
    //print(json.decode(response.body));
  return jsonDecode(response.body);
} 