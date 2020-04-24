import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/fragment/appbar/appbar.dart';
import 'package:flutterapp/globals.dart' as globals;
import 'package:flutterapp/pokeflex_icon_icons.dart';
import 'package:flutterapp/view/pokedexview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pokedex.dart';
import '../pokemon.dart';
import 'pokemonview.dart';

class ConfirmationView extends StatefulWidget{
  final String title = "Confirmation";
  final Pokedex pokedex;

  const ConfirmationView({Key key, @required this.pokedex}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _ConfirmationState(pokedex);
}

class _ConfirmationState extends State<ConfirmationView>{
  Pokedex pokedex;

  _ConfirmationState(this.pokedex);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Confirmation")),
      body: Center(
          child : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: 60,
                  child: Center(
                    child: Image(image: AssetImage('images/poke_center.png')),
                  )
              ),
              Container(
                child: Image(image: AssetImage('images/market_center.png')),
                padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
              ),
              Container(
                  height: 60,
                  child: Center(
                    child: Text("Retrouvez vos Pokémons au PokeCenter le plus proche !"),
                  )
              ),
            ],
          )
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PokedexView.pok(pokedex: pokedex)),
            );
          },
          backgroundColor: Colors.blue,
          elevation: 10,
          splashColor: Colors.red
      ),
    );
  }
}