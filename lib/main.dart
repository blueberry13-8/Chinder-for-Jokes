import 'dart:core';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'cards_page.dart';
import 'firebase_options.dart';
import 'joke.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(JokeAdapter());
  await Hive.openLazyBox<Joke>('box_for_joke');
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch(e){
    debugPrint(e);
  }
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Chinder for Jokes',
      theme: ThemeData(
        //primarySwatch: Colors,
        colorScheme: const ColorScheme.dark(),
      ),
      //home: const MyHomePage(title: 'Jokes'),
      home: const MyHomePage(
        title: 'Jokes',
      ),
    );
  }
}
