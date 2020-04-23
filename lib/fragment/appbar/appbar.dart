import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pokeflex_icon_icons.dart';
import 'package:flutterapp/globals.dart' as globals;
import 'package:flutterapp/view/favoriteview.dart';

import '../../pokedex.dart';

class AppBarView extends StatefulWidget implements PreferredSizeWidget{
	final Pokedex pokedex;
	final String title;
	final IconData icon;
	final bool currentViewIsFavortieView;
	@override
	final Size preferredSize;
	AppBarView({Key key, @required this.title, @required this.pokedex, this.icon, @required this.currentViewIsFavortieView}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

	@override
	State<StatefulWidget> createState() => AppBarState(pokedex, title, icon, currentViewIsFavortieView);

}

class AppBarState extends State<AppBarView>{
	Pokedex pokedex;
	String title;
	IconData icon;
	final ValueNotifier<int> _counter = ValueNotifier<int>(0);
	bool currentViewIsFavortieView;

	AppBarState(Pokedex pokedex, String title, IconData icon, bool currentViewIsFavortieView){
		this.title = title;
		this.pokedex = pokedex;
		_counter.value = pokedex.getPokemonTeamCount();
		this.icon = icon;
		this.currentViewIsFavortieView = currentViewIsFavortieView;
	}

	@override
	void initState(){
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return AppBar(
			title: Text(title),
			//leading: Icon(icon),
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
			new IconButton(
        icon: Icon(PokeflexIcon.pokeball, size: 30),
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        onPressed: (value != 0 && !currentViewIsFavortieView) ? () {
        	Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavoriteView(pokedex : pokedex)),
          );
			} : null),
			value != 0 ? new Positioned(
				right: 8,
				bottom: 8,
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












