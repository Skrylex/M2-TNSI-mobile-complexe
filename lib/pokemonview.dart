import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/pokedex.dart';
import 'package:flutterapp/pokemon.dart';
import 'package:http/http.dart' as http;
import 'package:flutterapp/webservice.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert' as convert;



class PokemonView extends StatefulWidget {

	final String title = "Détails Pokemon";
	@override
	_PokemonState createState() => _PokemonState();
}

class _PokemonState extends State<PokemonView> {
	String pokemon;
	int id = 1;
	@override
	void initState() {
		super.initState();
		pokemon = "Click Me !";

		//WebService.getPokemon(1);
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
			),
			body: GridView.count(
				// Create a grid with 2 columns. If you change the scrollDirection to
				// horizontal, this produces 2 rows.
				crossAxisCount: 3,
				scrollDirection: Axis.horizontal,
				// Generate 100 widgets that display their index in the List.
				children: <Widget>[
					Text(pokemon),
					Image.network('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/'+id.toString()+'.png'),
					RaisedButton(
						onPressed: () async {
							var test = await WebService.getPokemon(id);
							/*setState(() {
							  setPokemon();
							});*/

						},
						child: Text('Clicked '+id.toString()+' times'),
					)
				]
			));
	}

	void setPokemon(){
		final myFuture = WebService.getPokemon(id);
		myFuture.then((resp) {
			setState(() {
				pokemon = resp[''];
			});
		});
		id+=1;
	}
}