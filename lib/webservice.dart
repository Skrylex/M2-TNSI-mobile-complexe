import 'dart:convert' as convert;
import 'package:flutterapp/pokedex.dart';
import 'package:flutterapp/pokemon.dart';
import 'package:http/http.dart' as http;

class WebService {
	static String domain = "https://pokeapi.co/api/v2/";

	static Future<Map<String, dynamic>> getPokemons() async {
		var url = WebService.domain + "pokedex/2";
		var response = await http.get(url);
		//print(response.body);
		return Future.sync(() => convert.jsonDecode(response.body));
	}

	static Future<Map<String, dynamic>> getPokemon(id) async {
		var url = WebService.domain + "pokemon/" + id.toString();
		var response = await http.get(url);
		//return Future.sync(() => convert.jsonDecode(response.body).toString());
		return Future.sync(() => convert.jsonDecode(response.body));
	}


//Fetch
// Future<Pokemon> fetchPokemon() => Future.delayed(Duration(seconds: 2), () => 'Salut');

}
