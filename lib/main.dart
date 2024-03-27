import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tweet/app.dart';
import 'package:tweet/core/local_db/shared_pref_manager.dart';
import 'package:tweet/design/app_theme.dart';
import 'package:tweet/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferencesManager.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darktheme,
      home: DecidePage(),
    );
  }
}
