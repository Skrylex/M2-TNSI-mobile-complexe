library pokeflex.globals;

import 'package:flutter/material.dart';
import 'package:flutterapp/pokemon.dart';


final ValueNotifier<int> counter = ValueNotifier<int>(0);
final int LimiteTeam = 6;
List<Pokemon> savedPokemon = new List<Pokemon>();