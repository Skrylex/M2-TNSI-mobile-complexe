import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/fragment/appbar/appbar.dart';
import 'package:flutterapp/view/pokedexview.dart';
import 'pokedex.dart';
import 'pokemon.dart';
import 'webservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterapp/globals.dart' as globals;
import 'package:permission/permission.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'PokeFlex',
			theme: ThemeData(
				// This is the theme of your application.
				//
				// Try running your application with "flutter run". You'll hysee the
				// application has a blue toolbar. Then, without quitting the app, try
				// changing the primarySwatch below to Colors.green and then invoke
				// "hot reload" (press "r" in the console where you ran "flutter run",
				// or simply save your changes to "hot reload" in a Flutter IDE).
				// Notice that the counter didn't reset back to zero; the application
				// is not restarted.
				primarySwatch: Colors.blue,
			),
			home: MyHomePage(),
		);
	}

}

class MyHomePage extends StatefulWidget {
	MyHomePage({Key key}) : super(key: key);
	final String title = "PokeHome";
	@override
	_MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
	Pokedex pokedex = new Pokedex();

	@override
	void initState() {
		super.initState();
		loadTeam();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBarView(title: widget.title, pokedex: pokedex, icon: Icons.home, activateFavorites: false),
			body: Center(
				child :
				Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: <Widget>[
						Flexible(child:Image(image: AssetImage('images/logo_title.png'))),
						Flexible(child:Image(image: AssetImage('images/pokeball.png'))),
						initPokedex(),
					],
				)
			)
		);
	}

	Widget initPokedex(){
		//loadTeam();
		if(pokedex.pokemonsList.isEmpty) {
			return FutureBuilder<Pokedex>(
				future: WebService.fetchPokedex(),
				builder: (BuildContext context, AsyncSnapshot<Pokedex> snapshot) {
					if (!snapshot.hasData){
						return new Center(child : new CircularProgressIndicator());
					}
					pokedex = new Pokedex.list(snapshot.data.pokemonsList);
					Timer.run(() {
						Navigator.pushReplacement(
							context,
							MaterialPageRoute(builder: (context) => PokedexView.pok(pokedex : pokedex)),
						);
					});
					return Container();
				},
			);
		}
	}

	void loadTeam() async{
		print("---");
		print(globals.savedPokemon);
		if(globals.savedPokemon == null || globals.savedPokemon.isEmpty){
			final SharedPreferences prefs = await SharedPreferences.getInstance();
			print("^^^^^");
			String s = prefs.get('team');
			print("String : "+s);
			if(s != null){
				setState(() {
					globals.savedPokemon = decodeJsonSharedPreferences(jsonDecode(s));
					globals.counter.value = globals.savedPokemon.length;
					print(globals.savedPokemon);
				});
			}
		}
	}

	List<Pokemon> decodeJsonSharedPreferences(json){
		List<Pokemon> p = new List();
		for(dynamic s in json){
			p.add(new Pokemon.factory(id : s['id'],name: s['name'],infos : s['infos'], saved: s['saved']));
		}
		return p;
	}


}
