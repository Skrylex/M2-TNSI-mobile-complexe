import 'dart:convert' as convert;
import 'package:flutterapp/pokedex.dart';
import 'package:flutterapp/pokemon.dart';
import 'package:http/http.dart' as http;

class WebService {
	static String domain = "https://pokeapi.co/api/v2/";

	static Future<Pokedex> createOrderPokedex() async {
		var order = await fetchPokedexOrder();
		return order;
	}

	static Future<Pokedex> fetchPokedexOrder() async {
		var url = WebService.domain + "pokedex/2";
		var response = await http.get(url);
		print(convert.jsonDecode(response.body));
		return Future.delayed(Duration(seconds: 3),
				() => Pokedex.fromJson(convert.jsonDecode(response.body)));
	}

	//CreateOrder
	static Future<http.Response> getPokemon(id) async {
		var url = WebService.domain + "pokemon/" + id.toString();
		var response = await http.get(url);
		return Future.sync(() => response);
	}

//Fetch
// Future<Pokemon> fetchPokemon() => Future.delayed(Duration(seconds: 2), () => 'Salut');

}
