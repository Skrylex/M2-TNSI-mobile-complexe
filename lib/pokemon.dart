import 'package:flutterapp/pokemonview.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Pokemon {
	int id;
	String name;
	String sprite;

	Pokemon({this.id, this.name, this.sprite});

	factory Pokemon.fromJson(Map<String, dynamic> json) {
		return Pokemon(
			id: json['id'],
			name: json['pokemon_entries']['pokemon_species']['name'],
			sprite: null,
		);
	}

	@override
	String toString() {
		return 'Pokemon{id: $id, name: $name, sprite: $sprite}';
	}
}