import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
