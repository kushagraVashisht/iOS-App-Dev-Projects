//OG MY THING

// Importing the packages

// Adding import for validating package
import 'package:flutter/material.dart';
// The Validate package used for validating the arguments
import 'package:validate/validate.dart';
// The package for making the PUT Request
import 'dart:io';

void main() => runApp(new MaterialApp(
  home: new LoginPage(),
));

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return new MaterialApp
      (
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new LoginPage(),
    );
  }
}

// Creating a _LoginData class with email and password properties.
class _LoginData
{
  String email = '';
  String password = '';
}

// Creating a new login page,
class LoginPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin
{
  // Creating a key for the form we submit
  // Form state saves, resets and validates every FormField that is the descendant of the associated form.
  // Global keys is a key that is unique across the entire app. Global keys provide access to other objects that are associated with elements.

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  // Initialising the _LoginData to store the information once the data has been validated.
  _LoginData _data = new _LoginData();

  //Responsible for the animation part of the login page
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState()
  {
    super.initState();
    _iconAnimationController = new AnimationController
      (
        vsync: this, duration: new Duration(milliseconds: 500)
    );
    _iconAnimation = new CurvedAnimation
      (
        parent: _iconAnimationController,
        curve: Curves.bounceOut,
      );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  //Function to submit everything once validated
  void submit()
  {
    // First validate form.
    if (this._formKey.currentState.validate())
    {
      _formKey.currentState.save(); // Save our form now.
      print('Printing the login data.');
      print('Email: ${_data.email}');
      print('Password: ${_data.password}');
    }
  }

  //Function for validating the email address
  String _validateEmail(String value)
  {
    try
    {
      Validate.isEmail(value);
    }
    catch(e)
    {
      return 'The E-mail Address must be a valid email address.';
    }
    return null;
  }

//Function for validating the password
  String _validatePassword(String value)
  {
    if (value.length < 5)
    {
      return 'The Password must be at least 5 characters.';
    }
    return null;
    //return 'THE PROBLEM IS HERE AT THE PASSWORD BUTTON.';
  }


  @override
  Widget build(BuildContext context)
  {
    final Size screenSize = MediaQuery.of(context).size;

    return new Scaffold(
      backgroundColor: Colors.black87,
      body: new Stack(fit: StackFit.expand, children: <Widget>[
        new Theme(
          data: new ThemeData(
              brightness: Brightness.dark,
              inputDecorationTheme: new InputDecorationTheme(
                hintStyle: new TextStyle(color: Colors.blue, fontSize: 20.0),
                labelStyle:
                new TextStyle(color: Colors.tealAccent, fontSize: 25.0),
              )),
          isMaterialAppTheme: true,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image
                (
                image: new AssetImage("assets/logo.png"),
                height: _iconAnimation.value * 140.0,
              ),
              new Container(
                padding: const EdgeInsets.all(40.0),
                child: new Form(
                  key: this._formKey,
                  autovalidate: false,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new TextFormField(
                          keyboardType: TextInputType.emailAddress, // Use email input type for emails.
                          decoration: new InputDecoration(
                            hintText: 'you@example.com',
                            labelText: 'E-mail Address',
                            fillColor: Colors.white,
                          ),
                          validator: this._validateEmail,
                          onSaved: (String value)
                          {
                            this._data.email = value;
                          }
                      ),

                      new TextFormField(
                          obscureText: true, // Use secure text for passwords.
                          decoration: new InputDecoration
                            (
                            hintText: 'Password',
                            labelText: 'Enter your password',
                            fillColor: Colors.white,
                          ),
                          validator: this._validatePassword,
                          onSaved: (String value)
                          {
                            this._data.password = value;
                          }
                      ),

                      new Container
                        (
                        width: screenSize.width,
                        child: new RaisedButton(
                          child: new Text(
                            'Login',
                            style: new TextStyle(
                                color: Colors.white
                            ),
                          ),
                          onPressed: this.submit,
                          color: Colors.blue,
                        ),
                        margin: new EdgeInsets.only
                          (
                            top: 20.0
                        ),
                      )],
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
