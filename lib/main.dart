// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';

import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:textit/screens/welcome_screen.dart';
import 'package:textit/screens/login_screen.dart';
import 'package:textit/screens/registration_screen.dart';
import 'package:textit/screens/chat_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( Textit());
}

class Textit extends StatelessWidget {
  const Textit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kSecondaryColor),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        RegistrationScreen.id:(context)=>RegistrationScreen(),
        ChatScreen.id:(context)=>ChatScreen(),
      },
    );
  }
}