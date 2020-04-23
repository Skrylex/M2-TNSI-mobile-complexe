import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/globals.dart' as globals;

import '../../pokedex.dart';

class AppBarView extends StatefulWidget implements PreferredSizeWidget{
	final Pokedex pokedex;
	final String title;
	@override
	final Size preferredSize;
	AppBarView({Key key, @required this.title, @required this.pokedex}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

	@override
	State<StatefulWidget> createState() => AppBarState(pokedex, title);

}

class AppBarState extends State<AppBarView>{
	Pokedex pokedex;
	String title;
	final ValueNotifier<int> _counter = ValueNotifier<int>(0);


	AppBarState(Pokedex pokedex, String title){
		this.title = title;
		this.pokedex = pokedex;
		_counter.value = pokedex.getPokemonTeamCount();
	}

	@override
	void initState(){
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return AppBar(
			title: Text(title),
			actions: <Widget>[
						ValueListenableBuilder(
							builder: (BuildContext context, int value, Widget child) {
								// This builder will only get called when the _counter
								// is updated.

								return Stack(
									children: getIconNotification(value),
								);
							},
							valueListenable: globals.counter,
							// The child parameter is most helpful if the child is
							// expensive to build and does not depend on the value from
							// the notifier.
						)
			],
		);
	}

	List<Widget> getIconNotification(value){
		return <Widget>[
			new IconButton(icon: Icon(Icons.notifications), onPressed: null),
			globals.counter.value != 0 ? new Positioned(
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
						value.toString(),
						style: TextStyle(
							color: Colors.white,
							fontSize: 8,
						),
						textAlign: TextAlign.center,
					),
				),
			) : new Container()
		];
	}
}












