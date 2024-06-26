import 'package:flutter/material.dart';
import 'package:simple_login_app2/page/drawerviewpage.dart';
import 'package:simple_login_app2/page/loginpage.dart';
import 'package:simple_login_app2/page/tabviewpage.dart';

void main() {
  runApp(const MyApp(home: LoginPage(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.home});
  final Widget home;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
       useMaterial3: true,
      ),
      home: home
    );
  }
}

