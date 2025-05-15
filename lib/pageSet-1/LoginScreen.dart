import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentzy/Authentication/Auth.dart';
import 'package:rentzy/HomePages/MainHome.dart';
import 'package:rentzy/Reset%20Password/ForgotPassword.dart';
import 'package:rentzy/pageSet-1/SignupScreen.dart';
import 'package:rentzy/pageSet-1/SplashScreenPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Authentication/MetaMaskAuth.dart';
import '../BottomNavBar/BottomNavigationBar.dart';
import '../Database/UserDetails.dart';
import 'WelcomeScreen.dart';

List<String> logo = [
  "assets/images/Onboarding/google.svg",
  "assets/images/Onboarding/facebook.svg",
  "assets/images/Onboarding/apple.svg"
];

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  String? errorMessage = '';
  bool isLogin = true;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  String password = '';
  String email = '';
  bool isVisible = true;
  final formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool _isLoading = false;

  Future<void> GoogleSignin() async {
    try {
      setState(() => _isLoading = true);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Authenticating with Google...'),
          duration: Duration(seconds: 2),
        ),
      );

      await Future.delayed(const Duration(seconds: 1));

      await Authentication().SigninWithGoogle();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      debugPrint('Google Sign-In: isLoggedIn set to true');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Google authentication successful!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNav()),
      );
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Google sign-in failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      debugPrint('Google Sign-In Error: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      // Validate form first
      final isValid = formKey.currentState!.validate();
      if (!isValid) return;

      setState(() => _isLoading = true);
      FocusScope.of(context).unfocus();

      // Show initial authentication message
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Authenticating your details...'),
            duration: Duration(seconds: 2),
          ));

          // Add 1 second delay
          await Future.delayed(const Duration(seconds: 1));

    // Then proceed with authentication
    await Authentication().SignInWithEmailAndPassword(
    email: emailcontroller.text,
    password: passwordcontroller.text,
    );

    // Set login state
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    debugPrint('Email Login: isLoggedIn set to true');

    if (!mounted) return;

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
    content: Text('Authentication successful!'),
    backgroundColor: Colors.green,
    ),
    );

    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const BottomNav()),
    );
    } on FirebaseAuthException catch (e) {
    setState(() => _isLoading = false);
    String message = 'Authentication failed';
    debugPrint("FirebaseAuthException:${e.code}");

    if (e.code == 'invalid-credential') {
    message = 'Invalid email or password';
    }

    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text(message),
    backgroundColor: Colors.red,
    ),
    );
    } catch (e) {
    setState(() => _isLoading = false);
    debugPrint("Generic Error: $e");
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text('An error occurred. Please try again.'),
    backgroundColor: Colors.red,
    ),
    );
    } finally {
    if (mounted) {
    setState(() => _isLoading = false);
    }
    }
  }

  @override
  void initState() {
    super.initState();
    emailcontroller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back,
                          size: 30, color: Colors.black),
                    )
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/Onboarding/car.png",
                      height: 130, width: 150)
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Login to ur Account ",
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
              ),
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          final pattern = RegExp(
                              r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}');

                          if (value!.isEmpty) {
                            return 'Enter a email';
                          } else if (!pattern.hasMatch(value)) {
                            return 'Enter a valid email';
                          } else {
                            return null;
                          }
                        },
                        controller: emailcontroller,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email_outlined, size: 25),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.red, width: 1.0),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.0),
                            ),
                            errorStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Colors.red),
                            suffixIcon: emailcontroller.text.isEmpty
                                ? Container(width: 0)
                                : IconButton(
                                onPressed: () {
                                  emailcontroller.clear();
                                },
                                icon: const Icon(Icons.close, size: 25)),
                            hintText: 'Email',
                            hintStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(13)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0))),
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        validator: (value) {
                          if (value!.length < 8) {
                            return 'Enter a valid password';
                          } else {
                            return null;
                          }
                        },
                        controller: passwordcontroller,
                        onFieldSubmitted: (value) =>
                            setState(() {
                              FocusScope.of(context).unfocus();
                            }),
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        obscureText: isVisible,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                            prefixIcon: const Icon(Icons.lock_outline_rounded,
                                size: 25, color: Colors.black),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.0),
                            ),
                            errorStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Colors.red),
                            suffixIcon: IconButton(
                              icon: isVisible
                                  ? const Icon(Icons.visibility_off,
                                  size: 25, color: Colors.black)
                                  : const Icon(Icons.visibility,
                                  size: 25, color: Colors.black),
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1.0)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2.0),
                            )),
                      ),
                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Remember me",
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black))),
                          Checkbox(
                              checkColor: Colors.white,
                              activeColor: Colors.black,
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              })
                        ],
                      ),

                      const SizedBox(height: 10),

                      GestureDetector(
                        onTap: _isLoading ? null : signInWithEmailAndPassword,
                        child: Container(
                          height: 50,
                          width: 380,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _isLoading ? Colors.grey : Colors.black),
                          child: Center(
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                color: Colors.white)
                                : Text("Sign in",
                                style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white))),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: Text("Forgot Password?",
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: Colors.black)))),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                              child: Divider(
                                indent: 15,
                                color: Colors.black12,
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text("or continue with ",
                                style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17))),
                          ),
                          Expanded(
                              child: Divider(
                                endIndent: 15,
                                color: Colors.black12,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                child: GridView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 70.0,
                      childAspectRatio: 0.4,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SizedBox(
                          child: InkWell(
                            onTap: () async {
                              if (index == 0) {
                                await GoogleSignin();
                              } else if (index == 1) {
                                await GoogleSignin();
                              } else {
                                GoogleSignin();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.grey)),
                              child: Center(
                                child: SvgPicture.asset(logo[index],
                                    height: 25, width: 30),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Colors.black54))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        MetaMaskLoginPage();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen()));
                      },
                      child: RichText(
                          text: TextSpan(
                              text: "Sign up",
                              style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}