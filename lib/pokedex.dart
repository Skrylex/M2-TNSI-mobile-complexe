import 'package:flutter/cupertino.dart';
import 'package:flutterapp/pokemon.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Pokedex {
  Future<Pokemon> pokemons;

  Pokedex({this.pokemons});

  factory Pokedex.fromJson(Map<int, dynamic> json) {
    return Pokedex(
      pokemons: json['pokemon_entries']['entry_number'],
    );
  }

  @override
  String toString() {
    print(this.pokemons);
    return 'Pokedex{pokemons: $pokemons}';
  }
}