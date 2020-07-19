import 'package:flutter/material.dart';
import 'package:moviedbapp/services/auth.dart';

import 'MovieTile/movie_tile.dart';
import 'authenicate/sign_in.dart';

class NavDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage("https://images.unsplash.com/photo-1545851876-eb2bbc712ca6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1575&q=80"),
                )
            ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Favorites'),
            onTap: ()  =>  {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => MovieTilePage(),
              ),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Logout'),
            onTap: () async =>  {
              await _auth.signOut(),
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => SignIn(),
              ),
              )
            },
          ),
        ],
      ),
    );
  }
}