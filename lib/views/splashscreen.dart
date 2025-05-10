import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movietest/views/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => const HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 26, 22, 43),
      body: Center(
        child: Image.asset(
          'images/splash.PNG',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
