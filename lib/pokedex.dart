import 'package:flutterapp/pokemon.dart';
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class Pokedex {
  Future<Pokemon> pokemons;

  Pokedex({this.pokemons});

  factory Pokedex.fromJson(Map<String, dynamic> json) {
    return Pokedex(
      pokemons: json['pokemon_entries'],
    );
  }

  @override
  String toString() {
    return 'Pokedex{pokemons: $pokemons}';
  }


}
