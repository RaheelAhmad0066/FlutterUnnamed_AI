import 'package:aichat/View/new_chat_form_screen/new_chat_form_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../View/walkthrough1_screen/walkthrough1_screen.dart';

String userimage = '';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    user.value = _auth.currentUser;

    super.onInit();
  }

  Future<void> handleSignInAndNavigateToHome(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential? userCredential =
            await _auth.signInWithCredential(credential);
        if (userCredential != null) {
          userimage = userCredential.user!.photoURL ?? '';
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: ((context) => NewChatFormScreen())),
              (route) => false);
        }
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    user.value = null;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: ((context) => Walkthrough1Screen())),
        (route) => false);
  }
}
