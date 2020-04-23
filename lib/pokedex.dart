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

  /*void populatePokedex(){
    final myFuture = WebService.getPokemons();
    myFuture.then((resp) {
      getPokemonsFromJson(resp);
    });
  }*/

  /*void getPokemonsFromJson(Map<dynamic, dynamic> s){
    //print(s['pokemon_entries'][0]);
    for(Map<dynamic, dynamic> pokemon in s['pokemon_entries']){
      var id = pokemon['entry_number'];
      var name = pokemon['pokemon_species']['name'];
      final myFuture = WebService.getPokemon(id);
      myFuture.then((resp) {
        print(resp);
        pokemons.add(new Pokemon.fromJson(resp));
      });
    }
  }*/

  Future<List<Pokemon>> getFuturePokemons() async {
    return Future.sync(() => pokemonsList);
  }

  Pokemon getPokemonById(_id) {
    for (Pokemon pok in pokemonsList) {
      if (pok.id == _id) return pok;
    }
    return null;
  }


  @override
  String toString() {
    return 'Pokedex{pokemons: $pokemonsList}';
  }
}