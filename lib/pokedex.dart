import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:flutterapp/pokemon.dart';
import 'package:flutterapp/webservice.dart';


@JsonSerializable()
class Pokedex{
  List<Pokemon> pokemonsList = new List<Pokemon>();

  Pokedex.factory({pokemons}){
    for(var s in pokemons) {
      this.pokemonsList.add(new Pokemon(s['entry_number'], s['pokemon_species']['name'], ''));
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

  Pokemon getPokemonById(id) {
    for(Pokemon p in pokemonsList) {
      if (p.id == id) return p;
    }
  }

  Future<List<Pokemon>> getFuturePokemons() async {
    return Future.sync(() => pokemonsList);
  }


  @override
  String toString() {
    print(this.pokemonsList);
    return 'Pokedex{pokemons: $pokemonsList}';
  }
}