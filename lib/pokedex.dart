import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:flutterapp/pokemon.dart';
import 'package:flutterapp/webservice.dart';


@JsonSerializable()
class Pokedex{
  List<Pokemon> pokemons = new List<Pokemon>();

  Pokedex(){
    populatePokedex();
  }

  void populatePokedex(){
    final myFuture = WebService.getPokemons();
    myFuture.then((resp) {
      getPokemonsFromJson(resp);
    });
  }

  void getPokemonsFromJson(Map<String, dynamic> s){
    //print(s['pokemon_entries'][0]);
    for(Map<String, dynamic> pokemon in s['pokemon_entries']){
      var id = pokemon['entry_number'];
      var name = pokemon['pokemon_species']['name'];
      final myFuture = WebService.getPokemon(id);
      myFuture.then((resp) {
        //print(resp);
        var sprites = resp['sprites']['front_shiny'];
        var types = resp['types'];
        var abilities = resp['abilities'];
        pokemons.add(new Pokemon(id, name, sprites));
      });
    }
  }

  Pokemon getPokemonById(id) {
    for(Pokemon p in pokemons) {
      if (p.id == id) return p;
    }
  }


  @override
  String toString() {
    print(this.pokemons);
    return 'Pokedex{pokemons: $pokemons}';
  }
}