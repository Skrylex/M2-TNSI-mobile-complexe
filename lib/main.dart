import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pokedexview.dart';
import 'pokedex.dart';
import 'pokemon.dart';
import 'webservice.dart';

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
			home: MyHomePage(title: 'PokeHome'),

		);
	}

	static Widget layoutAppBar(_title, _pokedex) {
		return AppBar(
			// Here we take the value from the MyHomePage object that was created by
			// the App.build method, and use it to set our appbar title.
			title: Text(_title),
			actions: <Widget>[
				new Stack(
					children: <Widget>[
						new IconButton(icon: Icon(Icons.notifications), onPressed: null),
						_pokedex.getPokemonTeamCount() != 0 ? new Positioned(
							right: 11,
							bottom: 11,
							child: new Container(
								padding: EdgeInsets.all(2),
								decoration: new BoxDecoration(
									color: Colors.red,
									borderRadius: BorderRadius.circular(6),
								),
								constraints: BoxConstraints(
									minWidth: 14,
									minHeight: 14,
								),
								child: Text(
									_pokedex.getPokemonTeamCount().toString(),
									style: TextStyle(
										color: Colors.white,
										fontSize: 8,
									),
									textAlign: TextAlign.center,
								),
							),
						) : new Container()
					],
				)
			],
		);
	}
}

class MyHomePage extends StatefulWidget {
	MyHomePage({Key key, this.title}) : super(key: key);

	// This widget is the home page of your application. It is stateful, meaning
	// that it has a State object (defined below) that contains fields that affect
	// how it looks.

	// This class is the configuration for the state. It holds the values (in this
	// case the title) provided by the parent (in this case the App widget) and
	// used by the build method of the State. Fields in a Widget subclass are
	// always marked "final".

	final String title;

	@override
	_MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
	List<Pokemon> savedPokemon = new List<Pokemon>();
	Pokedex pokedex = new Pokedex();

	@override
	Widget build(BuildContext context) {
		// This method is rerun every time setState is called, for instance as done
		// by the _incrementCounter method above.
		//
		// The Flutter framework has been optimized to make rerunning build methods
		// fast, so that you can just rebuild anything that needs updating rather
		// than having to individually change instances of widgets.
		return Scaffold(
			appBar: MyApp.layoutAppBar(widget.title, pokedex),

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
		if(pokedex.pokemonsList.isNotEmpty){
			return RaisedButton(
				child: Text('Go to Pokedex'),
				onPressed: () {
					Navigator.push(
						context,
						MaterialPageRoute(builder: (context) => PokedexView.pok(pokedex : pokedex)),
					);
				},
			);
		}else{
			return FutureBuilder<Pokedex>(
				future: WebService.fetchPokedex(),
				builder: (BuildContext context, AsyncSnapshot<Pokedex> snapshot) {
					if (!snapshot.hasData){
						return new Center(child : new CircularProgressIndicator());
					}
					pokedex = new Pokedex.list(snapshot.data.pokemonsList);
					return RaisedButton(
						child: Text('Go to Pokedex'),
						onPressed: () {
							Navigator.push(
								context,
								MaterialPageRoute(builder: (context) => PokedexView.pok(pokedex : pokedex)),
							);
						},
					);
				},
			);
		}
	}
}
