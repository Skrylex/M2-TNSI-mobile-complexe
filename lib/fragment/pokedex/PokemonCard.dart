import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pokemon.dart';

import '../../pokedex.dart';
import '../../pokemonview.dart';

class PokemonCardView extends StatefulWidget{
  final int id;
  final Pokedex pokedex;
	const PokemonCardView.id({Key key, @required this.id, @required this.pokedex}) : super(key: key);

	@override
	_PokemonCardState createState() => _PokemonCardState(id, pokedex);
}

class _PokemonCardState extends State<PokemonCardView>{

	int id;
	Pokedex pokedex;
	Pokemon pokemon;

	_PokemonCardState(int id, Pokedex pok){
		this.id = id;
		this.pokedex = pok;
		this.pokemon = pokedex.pokemonsList.elementAt(this.id-1);
	}

	@override
	void initState() {
		super.initState();
	}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
			onTap: () {
				Navigator.push(
					context,
					MaterialPageRoute(builder: (context) => PokemonView.pok(pokedex: pokedex, id:pokemon.id)),
				);
			},
			child: Card(
				child : Column(
					children: <Widget>[
						Text(pokemon.name),
						Flexible(
							child :
							Image.network("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/" + (pokedex.pokemonsList.elementAt(this.id).id-1).toString() + ".png")
							//Image(image: AssetImage('images/pokeball.png'))
						)
						//Image.network("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/" + pok.id.toString() + ".png")
					],
				)
			)
		);
  }

}