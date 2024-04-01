import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tweet/core/config.dart';
import 'package:tweet/features/auth/modals/user_modal.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  static Future<UserModal?> getUserRepo(String uid) async {
    try {
      Dio dio = Dio();
      final response = await dio.get(Config.server_url + "user/$uid");
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        UserModal userModal = UserModal.fromMap(response.data);
        return userModal;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> createUserRepo(UserModal userModal) async {
    Dio dio = Dio();
    final response =
        await dio.post(Config.server_url + "user", data: userModal.toMap());
    if (response.statusCode! >= 200 && response.statusCode! <= 300) {
      return true;
    } else {
      return false;
    }
  }

  static Future<UserCredential?> signWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print(userCredential.user?.displayName);
      print(userCredential.user?.email);
      print(userCredential.user?.uid);
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> signOut() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut();
      await _googleSignIn.disconnect();
      await _googleSignIn.currentUser?.clearAuthCache();
    } catch (error) {
      print('error: $error');
    }
  }
}
