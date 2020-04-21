import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The base class for the different types of items the list can contain.
abstract class ListItem {
	/// The title line to show in a list item.
	Widget buildTitle(BuildContext context);
	Widget buildImage(BuildContext context);
}

/// A ListItem that contains data to display a message.
class PokemonItem implements ListItem {
	final String pokemonName;
	final String pokemonSprites;

	PokemonItem(this.pokemonName, this.pokemonSprites);

	Widget buildTitle(BuildContext context) => Text(pokemonName);
	Widget buildImage(BuildContext context) => Text(pokemonSprites);
}

