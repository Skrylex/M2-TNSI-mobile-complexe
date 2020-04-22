import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pokemon.dart';

import '../../pokemonview.dart';

class PokemonCardView extends StatefulWidget{
  final Pokemon pokemon;
	const PokemonCardView.pok({Key key, @required this.pokemon}) : super(key: key);

	@override
	_PokemonCardState createState() => _PokemonCardState(pokemon);
}




class _PokemonCardState extends State<PokemonCardView>{

	Pokemon pokemon;

	_PokemonCardState(Pokemon pok){
		this.pokemon = pok;
	}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
			onTap: () {
				Navigator.push(
					context,
					MaterialPageRoute(builder: (context) => PokemonView.pok(pokemon: pokemon)),
				);
			},
			child: Card(
				child : Column(
					children: <Widget>[
						Text(pokemon.name),
						Flexible(
							child :
							Image.network("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/" + pokemon.id.toString() + ".png")
							//Image(image: AssetImage('images/pokeball.png'))
						)
						//Image.network("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/" + pok.id.toString() + ".png")
					],
				)
			)
		);
  }

}