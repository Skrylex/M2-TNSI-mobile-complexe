import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../pokemon.dart';
import '../../webservice.dart';

class DetailsText extends StatefulWidget{
	final Pokemon pokemon;

	const DetailsText.pok({Key key, @required this.pokemon}) : super(key: key);

	@override
	State<StatefulWidget> createState() => _DetailsTextState(pokemon);
}

class _DetailsTextState extends State<DetailsText>{
	Pokemon pokemon;

	_DetailsTextState(Pokemon pok){this.pokemon = pok;}
	@override
	void initState(){
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		// TODO: implement build
		if(pokemon.infos?.isEmpty ?? true){
			return Container(
				padding: const EdgeInsets.all(32),
				child:FutureBuilder<String>(
					future: WebService.getInfosById(pokemon.id),
					builder: (context, snapshot) {
						if (snapshot.hasData) {
							pokemon.infos = snapshot.data;
							return Text(pokemon.infos);
						} else if (snapshot.hasError) {
							//TODO return to pokedex with toast error
							return Text("${snapshot.error}");
						}
						// By default, show a loading spinner.
						return CircularProgressIndicator();
					},
				)

			);
		}else{
			return Container(
				padding: const EdgeInsets.all(32),
				child:Text(pokemon.infos,
					softWrap: true,
				)
			);
		}
	}
}