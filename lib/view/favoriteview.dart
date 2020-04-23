import 'package:flutter/material.dart';
import 'package:flutterapp/fragment/appbar/appbar.dart';
import 'package:flutterapp/globals.dart' as globals;
import 'package:flutterapp/pokeflex_icon_icons.dart';
import '../pokedex.dart';
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
			appBar: AppBarView(title:"Votre équipe", pokedex: pokedex, icon: Icons.star, currentViewIsFavortieView: true),
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
									print(pokedex.pokemonsList.length);
									print(pokedex.getPokemonById(pokemon.id));
									if(pokedex != null && pokedex.pokemonsList.isNotEmpty){
										pokedex.getPokemonById(pokemon.id).saved = false;
									}
									pokemon.saved = false;
									print(pokedex.getPokemonById(pokemon.id));
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

			)
		);
	}

}