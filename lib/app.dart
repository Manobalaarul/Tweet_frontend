import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tweet/core/local_db/shared_pref_manager.dart';
import 'package:tweet/features/onboarding/ui/onboarding_screen.dart';
import 'package:tweet/features/tweet/ui/tweets_page.dart';

class DecidePage extends StatefulWidget {
  static StreamController<String?> authStream = StreamController.broadcast();
  const DecidePage({super.key});

  @override
  State<DecidePage> createState() => _DecidePageState();
}

class _DecidePageState extends State<DecidePage> {
  @override
  void initState() {
    getUid();
    super.initState();
  }

  getUid() async {
    String uid = await SharedPreferencesManager.getUid();
    log(uid);
    if (uid.isEmpty) {
      DecidePage.authStream.add(null);
    } else {
      DecidePage.authStream.add(uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
        stream: DecidePage.authStream.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.toString());
            return TweetsPage();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return OnBoardingScreen();
          }
        });
  }
}
