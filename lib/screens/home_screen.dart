import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:moviedbapp/screens/search_bar.dart';
import 'package:moviedbapp/style/theme.dart' as Style;
import 'package:moviedbapp/widgets/now_playing.dart';
import 'package:moviedbapp/widgets/genres.dart';
import 'package:moviedbapp/widgets/persons.dart';
import 'package:moviedbapp/widgets/top_movies.dart';
import 'navdrawer.dart';
class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        actions: <Widget>[
            IconButton(
              onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SearchPage(),
                  ));
              },
              icon: Icon(Icons.search),
            ),
        ],


      ),

      body: ListView(
        children: <Widget>[
          NowPlaying(),
          GenresScreen(),
          PersonsList(),
          TopMovies(),
        ],
      ),
    );
  }
}
