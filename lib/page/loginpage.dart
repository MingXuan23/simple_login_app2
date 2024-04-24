import 'package:flutter/material.dart';
import 'package:simple_login_app2/model/user.dart';
import 'package:simple_login_app2/page/homepage.dart';
import 'package:simple_login_app2/repo/user_repo.dart';
import 'package:simple_login_app2/widget/loginText.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() async {
    int userexist = await checkSavedUserData();
    if (userexist == 1) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyHomePage(title: "Hello AWord")));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'LOGIN',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 40, letterSpacing: 20),
            ),
            TextField(
              controller: _usernameController,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  final result = await loginViaApi(
                      _usernameController.text, _passwordController.text);
                  if (result != 0) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            MyHomePage(title: "Hello AWord")));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Invalid User")));
                  }
                  // final result = await login(
                  //     _usernameController.text, _passwordController.text);

                  // if (result.username != "" && result.password != "") {
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (context) =>
                  //           MyHomePage(title: "Hello AWord")));
                  // } else {
                  //   ScaffoldMessenger.of(context)
                  //       .showSnackBar(SnackBar(content: Text("Invalid User")));
                  // }

                  // if(_usernameController.text == "mingxuan2" && _passwordController.text == "abc123"){
                  //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage(title: "Hello AWord")));
                  // }
                },
                child: Text('Login'))
          ],
        ),
      )),
    );
  }
}
