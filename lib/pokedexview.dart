import 'package:flutter/material.dart';
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
  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: GridView.builder(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          Pokemon pokemon = pokedex.getPokemonById(index + 1);
          return Card(
            child: (pokemon.sprite != null) ? Image.network(pokemon.sprite.toString()) : Image(image: AssetImage('images/pokeball.png')),
          );
        },
        itemCount: pokedex.pokemons.length,
      )
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: new FutureBuilder<Pokedex>(
        future: WebService.fetchPokedex(),
        builder: (BuildContext context, AsyncSnapshot<Pokedex> snapshot) {
          if (!snapshot.hasData) return new Card();
          print(snapshot.data);
          Map content = snapshot.data as Map;
          List<Pokemon> lista = new List<Pokemon>();
          content.forEach((index, pok) {
            print(pok);
            //lista.add(_pokemon);
          });
          return new GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 1.3,
            children: lista.map((Pokemon pok) {
              return new Card(/*pok: pok*/);
            }).toList(),
          );
        },
      ),
    );
  }
}