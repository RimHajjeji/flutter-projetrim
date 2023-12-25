import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),(){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget.child!), (route) => false);
    }
    );
    super.initState();
  }


@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'images/back.png', // Add the path to your image here
          fit: BoxFit.cover,
        ),
        const Center(
          child: Text(
            "Welcome To EventApp",
            style: TextStyle(
              color: Color.fromARGB(255, 141, 63, 135),
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      ], // <-- Added closing bracket for the children list
    ),
  );
  }
}