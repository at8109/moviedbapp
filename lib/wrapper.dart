import 'package:moviedbapp/screens/authenicate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:moviedbapp/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:moviedbapp/model/user.dart';

import 'model/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);


    // return either Home or Authenticate widget
    if(user == null) {
      return Authenticate();
    } else {
      return HomeScreen();
    }
  }
}