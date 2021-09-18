// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textit/screens/registration_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x5E003449),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(tag: 'discord',
                  child: SizedBox(
                    child: Image.asset('assets/icons/discord.png'),
                    height: 60.0,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  'Textit',
                  style: GoogleFonts.b612Mono(
                    fontSize: 50.0,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFF5FCF9),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 22.0),
              child: Material(
                elevation: 5.0,
                color: Color(0xFFF186BA),
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    //Go to login screen.
                    Navigator.pushNamed(context,LoginScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Login',
                    style: GoogleFonts.b612Mono(fontSize: 19.0,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Go to registration screen.
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                    style: GoogleFonts.b612Mono(fontSize: 19.0,
                        fontWeight: FontWeight.w900,
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
