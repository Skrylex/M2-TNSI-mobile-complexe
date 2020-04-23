import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Pokemon {
	int id;
	String name;
	String sprite;
	String infos = "";
	List<String> types = new List<String>();
	List<String> abilities = new List<String>();
	bool saved = false;

	Pokemon(this.id, this.name, this.sprite);
	factory Pokemon.clone(Pokemon p){
		return new Pokemon(p.id, p.name, p.sprite);
	}
	Pokemon.factory({this.id, this.name, this.sprite, this.infos, this.types, this.abilities});
  Pokemon.infos({this.infos});

	factory Pokemon.fromJson(Map<dynamic, dynamic> json) {
		return Pokemon.factory(
			id: json['id'],
			name: json['name'],
			sprite: json['sprites']['front_shiny'],
		);
	}

	factory Pokemon.fromJsonInfos(Map<dynamic, dynamic> json){
		return Pokemon.infos(
			infos : json['flavor_text_entries'][5]['flavor_text'],
		);
	}

	@override
	String toString() {
		return 'Pokemon{id: $id, name: $name, isSaved: $saved}\n';
	}
}