import 'package:flutter/material.dart';
import 'package:travelsync_client/widget/buildGroup.dart';
import 'package:travelsync_client/widget/join.dart';
import 'package:travelsync_client/widget/login_page.dart';
import 'package:travelsync_client/widget/mainloading.dart';

class AppStart extends StatelessWidget {
  const AppStart({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
<<<<<<< HEAD
      home: BuildGroup(),
=======
      home: SplashScreen(),
>>>>>>> parent of 2c6e2d0 (Merge branch 'main' into ish)
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 2초 후에 다음 화면으로 이동
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const StartingPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Mainloading();
  }
}
