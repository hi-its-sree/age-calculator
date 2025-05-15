import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rentzy/pageSet-1/LetsUIn.dart';
import 'package:rentzy/BottomNavBar/BottomNavigationBar.dart';
import 'package:rentzy/pageSet-1/WelcomeScreen.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

      debugPrint('[SPLASH] Auth State - isLoggedIn: $isLoggedIn, isFirstTime: $isFirstTime');

      // Wait for minimum splash duration
      await Future.delayed(const Duration(seconds: 3));

      if (!mounted) return;

      if (isLoggedIn) {
        debugPrint('[SPLASH] Navigating to BottomNav (User is logged in)');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomNav()),
        );
      } else if (isFirstTime) {
        debugPrint('[SPLASH] First time user - Navigating to WelcomeScreen');
        await prefs.setBool('isFirstTime', false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Welcomescreen()),
        );
      } else {
        debugPrint('[SPLASH] Returning user - Navigating to LetsUIn');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LetsUIn()),
        );
      }
    } catch (e) {
      debugPrint('[SPLASH] Error: $e');
      if (!mounted) return;
      // Fallback to welcome screen if something goes wrong
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Welcomescreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Lottie.asset(
                  "assets/animations/Animation - 1740159490809.json",
                  frameRate: const FrameRate(10),
                  height: screenHeight * 0.5,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Lottie.asset(
                "assets/animations/Animation - 1740133687751.json",
                height: screenHeight * 0.1,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}