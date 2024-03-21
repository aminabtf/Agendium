import 'package:easflow_v1/View/Home/splash_screen.dart';
import 'package:easflow_v1/View/Account/create_account.dart';
import 'package:easflow_v1/View/Account/edit_account.dart';

import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[900],
      ),
      home: CreateAccount(),
    );
  }
}
