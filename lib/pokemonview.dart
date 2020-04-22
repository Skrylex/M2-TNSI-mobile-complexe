import 'package:flutter/material.dart';
import 'package:flutterapp/fragment/details/DetailsText.dart';
import 'package:flutterapp/fragment/details/DetailsTitle.dart';
import 'package:flutterapp/pokemon.dart';
import 'package:flutter/foundation.dart';

class PokemonView extends StatefulWidget {

	final String title = "Détails Pokemon";
	final Pokemon pokemon;

  const PokemonView.pok({Key key, @required this.pokemon}) : super(key: key);

	@override
	_PokemonState createState() => _PokemonState(pokemon);
}

class _PokemonState extends State<PokemonView> {

	Pokemon pokemon;
	int id = 1;

	_PokemonState(Pokemon pok){
		this.pokemon = pok;
	}

	@override
	void initState() {
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
			),
			body: Column(
				children: <Widget>[
					Flexible(
						child:
							Image.network("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/" + pokemon.id.toString() + ".png",
								height: 150,
								fit:BoxFit.fill),
		//Image(image: AssetImage('images/pokeball.png'))
					),
					DetailsTitle.pok(pokemon: pokemon),
					DetailsText.pok(pokemon: pokemon)
				],
			)
		);
//			body: Container(
//				child : Center(
//					child : Column(
//						children: <Widget>[
//							Text(widget.pokemon.name),
//							Flexible(
//								child :
//								Image.network("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/" + pokemon.id.toString() + ".png")
//								// Image(image: AssetImage('images/pokeball.png')),
//							)
//						],
//					)
//				)
//			)
	}
}