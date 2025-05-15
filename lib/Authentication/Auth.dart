import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Authentication
{
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  User? get currentUser=>firebaseAuth.currentUser;

  Stream<User?>get authStateChanges=>firebaseAuth.authStateChanges();


  //login
  Future<void>SignInWithEmailAndPassword({
    required String email,
    required String password,
  }) async
  {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password);
  }


  //signup

  Future<void>createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async
  {
    try
        {
          await firebaseAuth.createUserWithEmailAndPassword(
              email: email,
              password: password);
        }
        on FirebaseAuthException catch(e)
    {
      rethrow;
    }
  }


  Future<void>ResetEmail({
    required String email}) async {
    try
        {
          firebaseAuth.sendPasswordResetEmail
            (
              email: email
            );
        }
    on FirebaseAuthException catch(e)
    {
      print(e.message);
    }
  }

  //Google sign in

Future<UserCredential?>SigninWithGoogle() async
{
  try
      {
        // interactive google sign in page
        final GoogleSignInAccount? guser=await GoogleSignIn().signIn();

        //obtain details from request
        final GoogleSignInAuthentication? gAuth=await guser?.authentication;

        //create new credenitails

        final credential=GoogleAuthProvider.credential(
          accessToken: gAuth?.accessToken,
          idToken: gAuth?.idToken
        );

        //finally sig in
        return await firebaseAuth.signInWithCredential(credential);
      }
  catch(e)
  {
    print(e.toString());

  }
  return null;
}

  //sign out

  Future<void>signOut() async
  {
    await firebaseAuth.signOut();
  }

}

