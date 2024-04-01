import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tweet/core/local_db/shared_pref_manager.dart';
import 'package:tweet/features/auth/repos/auth_repo.dart';
import 'package:tweet/features/onboarding/ui/onboarding_screen.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Image.asset(
              "assets/light_logo.png",
            ),
          ),
          IconButton(
              onPressed: () async {
                await SharedPreferencesManager.clearUser();
                AuthRepo.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => OnBoardingScreen()),
                    (route) => false);
              },
              icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
