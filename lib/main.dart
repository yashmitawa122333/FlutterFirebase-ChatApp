import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterchatapp/helper/helper_function.dart';
import 'package:flutterchatapp/pages/home_page.dart';
import 'package:flutterchatapp/pages/auth/login_page.dart';
import 'package:flutterchatapp/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.apiKey,
            appId: Constants.appId,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  initState() {
    super.initState();
    getUserLoggedInState();
  }

  getUserLoggedInState() async {
    await HelperFunction.getUserLoggedInSharedPreference().then((value){
      if(value != null){
        setState((){
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isSignedIn ? const HomePage() : const LoginPage(),
      theme: ThemeData(
        primaryColor: Constants().primaryColor,
        scaffoldBackgroundColor: const Color(0xffffffff),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
