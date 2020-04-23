import 'package:flutter/material.dart';
import 'package:flutterapp/fragment/appbar/appbar.dart';
import 'package:flutterapp/globals.dart' as globals;
import '../pokedex.dart';
import 'pokemonview.dart';

class FavoriteView extends StatefulWidget{
	final String title = "Détails Pokemon";
	final Pokedex pokedex;

	const FavoriteView({Key key, @required this.pokedex}) : super(key: key);


	@override
  State<StatefulWidget> createState() => _FavoriteState(pokedex);
}

class _FavoriteState extends State<FavoriteView>{
	Pokedex pokedex;
	_FavoriteState(Pokedex pokedex){
		this.pokedex = pokedex;
	}
	@override
	void initState() {
		super.initState();
	}

	@override
  Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBarView(title:"Pokémon Favoris", pokedex: pokedex, icon: Icons.star, currentViewIsFavortieView: true),
			body: ListView.builder(
				itemCount: globals.savedPokemon.length,
				itemBuilder: (context, index){
					final pokemon = globals.savedPokemon.elementAt(index);

					return GestureDetector(
						onTap: () {
							Navigator.push(
								context,
								MaterialPageRoute(builder: (context) => PokemonView.pok(pokedex: pokedex, id:pokemon.id)),
							);
						},
						child : Dismissible(
							background: Container(
								alignment: AlignmentDirectional.centerEnd,
								color: Colors.red,
								child: Padding(
									padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
									child: Icon(Icons.delete,
										color: Colors.white,
									),
								),
							),
							key : Key(pokemon.id.toString()),
							onDismissed: (direction){
								setState(() {
									pokemon.saved = false;
									globals.savedPokemon.remove(pokemon);
									globals.counter.value = pokedex.getPokemonTeamCount();
								});
							},
							child : ListTile(
								title: Row(
									children: <Widget>[
										Flexible(
											child:
											Image.network("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/" + pokemon.id.toString() + ".png",
												height: 50,
												fit:BoxFit.fill),
											//Image(image: AssetImage('images/pokeball.png'))
										),
										Padding(
											padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
											child :Text(pokemon.name.toUpperCase(), style: TextStyle(fontSize: 20))
										)
									],
								)
							)
						)
					);
				},

			)
		);
	}

}