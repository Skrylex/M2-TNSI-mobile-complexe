import 'package:flutter/material.dart';
import 'package:flutterapp/pokedex.dart';
import 'package:flutterapp/pokedex.dart';
import 'package:flutterapp/pokedexview.dart';
import 'package:flutterapp/pokemonview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Flutter Demo',
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
			home: MyHomePage(title: 'Accueil'),
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
			appBar: AppBar(
				// Here we take the value from the MyHomePage object that was created by
				// the App.build method, and use it to set our appbar title.
				title: Text(widget.title),
			),
			body: GridView.count(
				crossAxisCount: 2,
				scrollDirection: Axis.horizontal,
				// Center is a layout widget. It takes a single child and positions it
				children: <Widget>[
					RaisedButton(
						child: Text('Go to Pokemon'),
						onPressed: () {
							Navigator.push(
								context,
							//MaterialPageRoute(builder: (context) => PokedexView()),
								MaterialPageRoute(builder: (context) => PokemonView()),
							);
						},
					),
					RaisedButton(
						child: Text('Go to Pokedex'),
						onPressed: () {
							pokedex.populatePokedex();
							Navigator.push(
								context,
								MaterialPageRoute(builder: (context) => PokedexView()),
							);
						},
					),
				]
			),
		);
	}
}
