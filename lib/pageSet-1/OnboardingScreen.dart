import 'package:rentzy/pageSet-1/SplashScreenPage.dart';
import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<Introduction>list=[
    Introduction
      (
        imageUrl: "assets/images/Onboarding/car_onboarding.png",
        title: "hello",
        subTitle: "hi"),

    Introduction
      (   imageUrl: "assets/images/Onboarding/car_onboarding.png",
        title: "hello",
        subTitle: "hi"),

    Introduction
      (   imageUrl: "assets/images/Onboarding/car_onboarding.png",
        title: "hello",
        subTitle: "hi"),
  ];

  @override
  Widget build(BuildContext context) {

    var mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenHeight = mediaQueryData.size.height;


    return Scaffold(
      body: SafeArea(
          child: IntroScreenOnboarding(
            introductionList:list,
            foregroundColor: Colors.grey.shade500,
            backgroundColor: Colors.grey.shade200,
            skipTextStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontSize: 20,
            ),
            onTapSkipButton: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SplashScreenPage())),

          )),
    );
  }
}
