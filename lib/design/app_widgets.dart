import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tweet/core/local_db/shared_pref_manager.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        child: Image.asset(
          "assets/light_logo.png",
        ),
      ),
    );
  }
}
