import 'package:flutterapp/pokemonview.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Pokemon {
	int id;
	String name;
	String sprite;
	List<String> types = new List<String>();
	List<String> abilities = new List<String>();

	Pokemon(this.id, this.name, this.sprite);


	@override
	String toString() {
		return 'Pokemon{id: $id, name: $name, sprite: $sprite}';
	}
}