import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
										'Numéro de pokédex : '+pokemon.id.toString(),
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
								pokemon.saved ? Icons.star : Icons.star_border,
								color: pokemon.saved ? Colors.red[500] : null,
							),
							onPressed: (){
								setState(() {
									pokemon.saved = !pokemon.saved;
								});
							},
						),
					],
				),
			);

		}
}