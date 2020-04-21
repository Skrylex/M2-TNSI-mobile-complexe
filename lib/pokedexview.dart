import 'package:flutter/material.dart';
import 'package:flutterapp/listitem.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/pokedex.dart';
import 'package:flutterapp/pokemon.dart';
import 'package:flutterapp/webservice.dart';

class PokedexView extends StatefulWidget {
  @override
  _PokedexState createState() => _PokedexState();
}

class _PokedexState extends State<PokedexView> {
  @override
  void initState() {
    super.initState();
  }
  // Pokedex pokedex = new Pokedex();
  final List<ListItem> pokedex;
  _PokedexState({Key key, @required this.pokedex}) : super();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(151, (pokedex) {
          return Center(
            child: Text(
              'Item $pokedex',
              style: Theme.of(context).textTheme.headline,
            ),
          );
        }),
      )
    );
  }
}