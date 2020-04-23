import 'package:json_annotation/json_annotation.dart';
import 'package:flutterapp/pokemon.dart';


@JsonSerializable()
class Pokedex{
  List<Pokemon> pokemonsList = new List<Pokemon>();

  Pokedex();

  Pokedex.list(List<Pokemon> p){
    this.pokemonsList = p;
  }

  Pokedex.factory({pokemons}){
    for(var pok in pokemons){
      Pokemon p = new Pokemon(pok['entry_number'], pok['pokemon_species']['name'], '');
      this.pokemonsList.add(p);
    }
  }

  factory Pokedex.fromJson(Map<dynamic, dynamic> json) {
    return Pokedex.factory(
      pokemons: json['pokemon_entries']
    );
  }

  Future<List<Pokemon>> getFuturePokemons() async {
    return Future.sync(() => pokemonsList);
  }

  Pokemon getPokemonById(_id) {
    for (Pokemon pok in pokemonsList) {
      if (pok.id == _id) return pok;
    }
    return null;
  }

  int getPokemonTeamCount() {
    int counter = 0;
    for (Pokemon pok in pokemonsList) {
      if (pok.saved) counter++;
    }
    return counter;
  }


  @override
  String toString() {
    return 'Pokedex{pokemons: $pokemonsList}';
  }
}