import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:paymentassistant/screens/home_screen/homescreen.dart';
import 'package:paymentassistant/screens/log_in/loginscreen.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'screens/about_situation/nointernet.dart';


FirebaseAuth auth = FirebaseAuth.instance;

SharedPreferences? sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Connectivity().checkConnectivity().then((value) {
    if (value == ConnectivityResult.none) {
      no_internet = true;
    }
    SharedPreferences.getInstance().then((value) {
      sharedPreferences = value;
      FlutterNativeSplash.remove();
      runApp(MyApp());
    });
  });
}

FirebaseFirestore firestore = FirebaseFirestore.instance;

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

bool no_internet = false;

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: no_internet == false
          ? sharedPreferences!.getBool("remember") != true
          ? LoginScreen()
          : HomeScreen()
          : NoInternets(),
    );
  }
}