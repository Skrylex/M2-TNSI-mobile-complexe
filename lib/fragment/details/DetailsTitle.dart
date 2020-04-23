import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pokeflex_icon_icons.dart';
import 'package:flutterapp/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import '../../pokedex.dart';
import '../../pokemon.dart';

class DetailsTitle extends StatefulWidget{
	final Pokedex pokedex;
	final int id;
	const DetailsTitle.pok({Key key, @required this.id, @required this.pokedex}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailsTitleState(pokedex, id);
}

class _DetailsTitleState extends State<DetailsTitle>{
	Pokedex pokedex;
	Pokemon pokemon;
	int id;

	@override
	void initState(){
		super.initState();
	}

	_DetailsTitleState(Pokedex pok, int id ){
		this.pokedex = pok;
		this.id = id;
		this.pokemon = pok.pokemonsList.elementAt(id-1);
	}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
				padding: const EdgeInsets.all(32),
				child: Row(
					children: [
						Expanded(
							/*1*/
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									/*2*/
									Container(
										padding: const EdgeInsets.only(bottom: 8),
										child: Text(
											pokemon.name.toUpperCase(),
											style: TextStyle(
												fontWeight: FontWeight.bold,

											),
										),
									),
									Text(
										'Numéro de pokédex : #'+pokemon.id.toString(),
										style: TextStyle(
											color: Colors.grey[500],
										),
									),
								],
							),
						),
						/*3*/
						IconButton(
							icon : Icon(
								pokemon.saved ? PokeflexIcon.heart : PokeflexIcon.heart_empty,
								color: pokemon.saved ? Colors.red[500] : null,
							),
							onPressed: (){
								setState(() {
									if(pokemon.saved) { // REMOVE
										pokemon.saved = false;
										globals.savedPokemon.remove(pokemon);
									} else{ // ADD IF TEAM INF. 6 (Limit define in globals)
                    if (globals.counter.value < globals.teamSize) {
											pokemon.saved = true;
											globals.savedPokemon.add(pokemon);
										} else {
											showDialog(
													context: context,
													builder: (BuildContext context) {
														return AlertDialog(
															title: new Text("Équipe complète"),
															content: new Text("Tu ne peux pas avoir plus de " + globals.teamSize.toString() + " pokémons dans ton équipe."),
															actions: <Widget>[
																new FlatButton(
																		onPressed: () {
																			Navigator.of(context).pop();
																		},
																		child: new Text("Fermer")
																)
															],
														);
													}
											);
										}
									}
									globals.counter.value = globals.savedPokemon.length;
									saveTeam();
								});
							},
						),
					],
				),
			);
		}

	Future<Null> saveTeam() async{
		final SharedPreferences prefs = await SharedPreferences.getInstance();
		print("***");
		print(Pokemon.encodeToJson(globals.savedPokemon));
		setState(() {
			prefs.setString('team', jsonEncode(globals.savedPokemon));
		});
	}


}