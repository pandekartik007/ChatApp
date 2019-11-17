import 'package:flutter/material.dart';
import 'package:my_chat/rounded_button.dart';
import 'package:my_chat/screens/chat_screen.dart';
import 'package:my_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
// using the underscore in Dart make the property private
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                  decoration: kTextFieldsDecoration.copyWith(
                      hintText: 'Enter your email')),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },style: TextStyle(
                color: Colors.black,
                fontSize: 12.0,
              ),
                  decoration: kTextFieldsDecoration.copyWith(
                      hintText: 'Enter your Password')),
              SizedBox(
                height: 24.0,
              ),
              new RoundedButton(
                  title: 'Register',
                  color: Colors.blueAccent,
                  onPressed: () async {
                    setState(() {
                      _showSpinner = true;
                    });

                    print('email  ' + email);
                    print('password  ' + password);
                    try {
                      final newUser =

                      await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      if (newUser != null) {
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (context) =>
                            new ChatScreen())
                        );
                      }
                      setState(() {
                        _showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}