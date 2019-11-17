import 'package:flutter/material.dart';
import 'package:my_chat/screens/login_screen.dart';
import 'package:my_chat/screens/registration_screen.dart';
import 'package:my_chat/rounded_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    // TODxO: implement initState
    super.initState();

    controller = new AnimationController(
        duration: Duration(seconds: 1),
        vsync:
        this, // Using this keyword states that we are pointing back to the welcomeScreenState
        upperBound: 1.0);

    // animation = new CurvedAnimation(parent: controller, curve: Curves.easeIn);

    // controller.forward();
    //controller.reverse(from: 1.0);

    //AnimationStatus.completed - on forward
    //AnimationStatus.dismissed - on reverse

    // controller.addStatusListener((status) {
    //   if (status == AnimationStatus.completed)
    //     controller.reverse(from: 1.0);
    //   else if (status == AnimationStatus.dismissed) controller.forward();
    // });

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(
              () {}); // force Widget(build() to be called to update and show our animation)
    });
  }

  @override
  void dispose() {
    // overide dispose and place contollers and anmations inside to kill because the remain
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 60,
                    ),
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['My Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            new RoundedButton(
                title: 'Login',
                color: Colors.lightBlueAccent,
                onPressed: () {
                  //Navigator.pushNamed(context, LoginScreen.id);
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                      new LoginScreen())
                  );
                }),
            new RoundedButton(
                title: 'Register',
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                      new RegistrationScreen())
                  );
                }),
          ],
        ),
      ),
    );
  }
}