import 'package:flutter/material.dart';
import 'package:moviedbapp/screens/home_screen.dart';
import 'package:moviedbapp/services/auth.dart';
import 'package:moviedbapp/wrapper.dart';
import 'package:provider/provider.dart';

import 'model/user.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}