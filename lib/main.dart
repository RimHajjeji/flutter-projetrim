import 'package:event_projet/features/app/splash_screen/splash_screen.dart';
import 'package:event_projet/features/user_auth/presentation/pages/home_page.dart';
import 'package:event_projet/features/user_auth/presentation/pages/login_page.dart';
import 'package:event_projet/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

if(kIsWeb){
await Firebase.initializeApp(options: const FirebaseOptions(
  apiKey: "AIzaSyDoxgpW5n-WHfEedH3KU3CgergKsJpehhg", 
  appId: "1:502288617321:web:63e14b25a2f281f3c277f8", 
  messagingSenderId: "502288617321", 
  projectId: "eventprojet-f51ed",
  ),);
  } else {
    await Firebase.initializeApp();
  }
  runApp( 
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Projet',
      routes: {
        '/': (context) => const SplashScreen(
          // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
          child: LoginPage(),
        ),
        '/login': (context) => const LoginPage(),
        '/signUp': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}