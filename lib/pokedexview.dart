import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/pokedex.dart';
import 'package:flutterapp/webservice.dart';

class PokedexView extends State<MyHomePage> {
  Future<Pokedex> pokedex;

  @override
  void initState() {
    this.pokedex = WebService.getAllPokedex();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: Center(
        child: Text(this.pokedex.toString()),
        /*
        child: RaisedButton(
          child: Text("test"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),*/
      ),
    );
  }
}