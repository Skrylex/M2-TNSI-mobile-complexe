import 'package:flutter/material.dart';
import 'package:flutterapp/fragment/appbar/appbar.dart';
import 'package:flutterapp/fragment/details/DetailsText.dart';
import 'package:flutterapp/fragment/details/DetailsTitle.dart';
import 'package:flutterapp/view/main.dart';
import 'package:flutterapp/pokedex.dart';
import 'package:flutterapp/pokemon.dart';
import 'package:flutter/foundation.dart';

class PokemonView extends StatefulWidget {

	final String title = "Détails Pokemon";
	final Pokedex pokedex;
	final int id;

  const PokemonView.pok({Key key, @required this.id, @required this.pokedex}) : super(key: key);

	@override
	_PokemonState createState() => _PokemonState(pokedex, id);
}

class _PokemonState extends State<PokemonView> {
	Pokedex pokedex;
	Pokemon pokemon;
	int id;

	_PokemonState(Pokedex pok, int id){
		this.pokedex = pok;
		this.id = id;
		this.pokemon = pok.pokemonsList.elementAt(id-1);
	}

	@override
	void initState() {
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBarView(title:"Détails Pokémon", pokedex: pokedex, activateFavorites: true),
			body: Column(
				children: <Widget>[
					Flexible(
						child:
							Image.network("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/" + pokemon.id.toString() + ".png",
								height: 150,
								fit:BoxFit.fill),
		//Image(image: AssetImage('images/pokeball.png'))
					),
					DetailsTitle.pok(pokedex: pokedex, id:pokemon.id),
					DetailsText.pok(pokemon: pokemon)
				],
			)
		);
	}


}