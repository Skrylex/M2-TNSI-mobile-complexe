import 'package:flutter/material.dart';
import 'package:flutterapp/fragment/appbar/appbar.dart';
import 'package:flutterapp/globals.dart' as globals;
import '../pokedex.dart';

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
			appBar: AppBarView(title:"Pokémon Favoris", pokedex: pokedex, icon: Icons.star),
			body: ListView.builder(
				itemCount: globals.savedPokemon.length,
				itemBuilder: (context, index){
					final item = globals.savedPokemon.elementAt(index);

					return ListTile(
						title: Text(item.name)
					);
				},

			)
		);
	}

}