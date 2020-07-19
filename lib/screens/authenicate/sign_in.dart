import 'package:flutter/gestures.dart';
import 'package:moviedbapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:moviedbapp/shared/constants.dart';
import 'package:moviedbapp/shared/loading.dart';

class SignIn extends StatefulWidget {

    final Function toggleView;
    SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService(); 
  final _formKey = GlobalKey<FormState>();
  bool loading = false;


  // Text Field State
  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Movie App'),
        actions: <Widget>[
          FlatButton.icon(
          onPressed: () {
            widget.toggleView();
          }, 
          icon: Icon(Icons.person), 
          label: Text('Register')
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter an email': null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long': null,
                onChanged: (val) {
                    setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()) { // returns true or false
                        setState(() => loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                        if(result == null) {
                          setState(() => error = 'COULD NOT SIGN IN WITH THOSE CREDENTIALS');
                          loading = false;
                        }
                  }
                } 
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignInScreen extends StatefulWidget{

  final Function toggleView;
  SignInScreen({ this.toggleView });

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;


  // Text Field State
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1594643566940-893b456ae452?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1575&q=80'),
              fit: BoxFit.cover
              )
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {}
                ),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 4, right: 10),
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) => val.isEmpty ? 'Enter an email': null,
                        onChanged: (val) {
                          setState(() => email = val);
                        }
                      ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.lock),
                    onPressed: () {}
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 4, right: 10),
                    child: TextFormField(
                          decoration: textInputDecoration.copyWith(hintText: 'Password'),
                          obscureText: true,
                          validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long': null,
                          onChanged: (val) {
                            setState(() => password = val);
                            }
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RaisedButton(
              color: Color(0xFF00A790),
              child: Text(
              'Sign In',
              style: TextStyle(color: Colors.white),
            ),
              onPressed: () async {
                if(_formKey.currentState.validate()) { // returns true or false
                  setState(() => loading = true);
                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                  if(result == null) {
                    setState(() => error = 'COULD NOT SIGN IN WITH THOSE CREDENTIALS');
                    loading = false;
                  }
                }
              }
          ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, 'Register');
            },
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: 'Don\'t have an account ',
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      recognizer: TapGestureRecognizer(

                      ),
                      text: 'SIGN UP',
                      style: TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}