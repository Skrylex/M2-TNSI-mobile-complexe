import 'dart:convert' as convert;
import 'package:flutterapp/pokedex.dart';
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

    return Future.delayed(Duration(seconds: 3), () => Pokedex.fromJson(convert.jsonDecode(response.body)));
  }

  static void getPokemon(id) async {
    var url = WebService.domain + "pokemon/" + id;
    var response = await http.get(url);
  }
}