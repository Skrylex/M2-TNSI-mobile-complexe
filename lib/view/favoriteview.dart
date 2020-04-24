import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/fragment/appbar/appbar.dart';
import 'package:flutterapp/globals.dart' as globals;
import 'package:flutterapp/pokeflex_icon_icons.dart';
import 'package:flutterapp/view/confirmationview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pokedex.dart';
import '../pokemon.dart';
import 'pokemonview.dart';

class FavoriteView extends StatefulWidget{
	final String title = "Votre équipe";
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
			appBar: AppBarView(title:"Votre équipe", pokedex: pokedex, icon: Icons.star, activateFavorites: false),
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
								child: Icon(
									PokeflexIcon.trash_1,
									color: Colors.white,
								),
								padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
							),
							key : Key(pokemon.id.toString()),
							direction: DismissDirection.endToStart,
							onDismissed: (direction){
								setState(() {
									if(pokedex != null && pokedex.pokemonsList.isNotEmpty){
										pokedex.getPokemonById(pokemon.id).saved = false;
									}
									pokemon.saved = false;
									globals.savedPokemon.remove(pokemon);
									globals.counter.value = globals.savedPokemon.length;
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
			),
			floatingActionButton: FloatingActionButton.extended(
				onPressed: (globals.savedPokemon.length != 0) ? () {
					resetAll();
					Navigator.push(
						context,
						MaterialPageRoute(builder: (context) => ConfirmationView(pokedex: pokedex)),
					);
				} : null,
				label: Text('Valider'),
				icon: Icon(Icons.shopping_cart),
				backgroundColor: (globals.savedPokemon.length != 0) ? Colors.red : Colors.blueGrey,
				elevation: 10,
				splashColor: Colors.blue,
			),
			floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
		);
	}

	Future<Null> saveTeam() async{
		final SharedPreferences prefs = await SharedPreferences.getInstance();
		setState(() { prefs.setString('team', jsonEncode(globals.savedPokemon)); });
	}

	void resetAll() async {
		for(Pokemon p in globals.savedPokemon){
			pokedex.getPokemonById(p.id).saved = false;
		}
		globals.savedPokemon.clear();
		globals.counter.value = globals.savedPokemon.length;
		saveTeam();
	}

}