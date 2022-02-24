import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class HomePage extends StatefulWidget {
  final List curr;
  HomePage(this.curr);
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List curr;
  final List<MaterialColor> _colors = [Colors.blue,Colors.red,Colors.indigo];
  
 @override
  Widget build(BuildContext context) {
    return new Scaffold(
     
      body: _cryptoWidget(),
    );
  }
  Widget _cryptoWidget(){
    return new Container(
      color: Colors.teal,
      child:new Column(
        children:<Widget>[new Flexible(child: new ListView.builder(
          itemCount: widget.curr.length,
          itemBuilder: (BuildContext context, int index){
            final Map currency = widget.curr[index];
            final MaterialColor color = _colors[index%_colors.length];
      
            return _getListItemUi(currency,color);
          },
        )
        )
      ],
      ));
  }
  ListTile _getListItemUi(Map currency,MaterialColor color){
    return new ListTile(
      leading:  new CircleAvatar(backgroundColor: color,
      child : new Text(currency['name'][0])),
      title:  new Text(currency['name']),
      subtitle: _getSubtitleText(currency['quote']['USD']['price'].toString() ,currency['quote']['USD']['percent_change_24h'].toString()  ),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(String priceUSD, String percentageChange){
    TextSpan priceTextWidget = new TextSpan(text: "\$$priceUSD\n");
    String prercentageChangeText = "1 hour $percentageChange%";
    TextSpan percentageChangeTextWidget;
    percentageChangeTextWidget = new TextSpan(text: prercentageChangeText);
    
    return new RichText(
      text: TextSpan(children:[priceTextWidget,percentageChangeTextWidget] )
    );

  }
}