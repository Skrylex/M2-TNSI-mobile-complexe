import 'dart:convert';
import 'dart:async';
import 'package:flutterapp/pokedex.dart';
import 'package:flutterapp/pokemon.dart';
import 'package:http/http.dart' as http;

class WebService {
	static String domain = "https://pokeapi.co/api/v2/";

	static Future<Pokedex> fetchPokedex() async {
		var url = WebService.domain + "pokedex/2";
		var response = await http.get(url);
		//return Future.sync(() => convert.jsonDecode(response.body).toString());
		return Pokedex.fromJson(jsonDecode(response.body));
	}

	static Future<Pokemon> fetchPokemon(id) async {
		var url = WebService.domain + "pokemon/" + id.toString();
		var response = await http.get(url);
		return Pokemon.fromJson(jsonDecode(response.body));
	}

	static Future<String> getInfosById(id) async {
		var url = WebService.domain + "pokemon-species/"+id.toString();
		var response = await http.get(url);

		for(Map<dynamic,dynamic> s in jsonDecode(response.body)['flavor_text_entries']){
			//print(s['language']['name'].toString() == 'fr');
			//print(s['language']['name'].toString() == 'fr' && (s['version']['name'].toString() == 'blue' || s['version']['name'].toString() == 'red' || s['version']['name'].toString() == 'alpha-sapphir' || s['version']['name'].toString() == 'omega-ruby' ));
			print('ok');
//			print(jsonDecode(s['flavor_text'].toString()));
//			print(jsonDecode(s['flavor_text'].toString().replaceAll("\\n", "")));
			if(s['language']['name'].toString() == "fr" && (s['version']['name'].toString() == 'blue' || s['version']['name'].toString() == 'red' || s['version']['name'].toString() == 'alpha-sapphir' || s['version']['name'].toString() == 'omega-ruby' )){
				print("OK : "+s['flavor_text'].toString().replaceAll("\n", ""));
				return (s['flavor_text'].toString().replaceAll("\n", " "));
			}
		}
		return jsonDecode(response.body)['flavor_text_entries'][5]['flavor_text'];
	}

	static Future<Map<dynamic, dynamic>> getPokemons() async {
		var url = WebService.domain + "pokedex/2";
		var response = await http.get(url);
		return Future.sync(() => jsonDecode(response.body));
	}

	static Future<Map<dynamic, dynamic>> getPokemon(id) async {
		var url = WebService.domain + "pokemon/" + id.toString();
		var response = await http.get(url);
		return Future.sync(() => jsonDecode(response.body));
	}




//Fetch
// Future<Pokemon> fetchPokemon() => Future.delayed(Duration(seconds: 2), () => 'Salut');

}
