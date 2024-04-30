import 'package:flutter/material.dart';
import 'package:simple_login_app2/model/user.dart';
import 'package:simple_login_app2/page/drawerviewpage.dart';
import 'package:simple_login_app2/page/homepage.dart';
import 'package:simple_login_app2/repo/user_repo.dart';
import 'package:simple_login_app2/widget/alertMessage.dart';
import 'package:simple_login_app2/widget/loginText.dart';
import 'package:simple_login_app2/widget/userTile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String username = "";
  List<dynamic> userlist = [];

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() async {
    int userexist = await checkSavedUserData();
    if (userexist == 1) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DrawerViewPage()));
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('heelo'),
         backgroundColor: Theme.of(context).canvasColor,
      ),
      body: SingleChildScrollView(
          child: Padding(   
        padding: EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                        
             Text(
              username,
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

                  if(_usernameController.text.isEmpty || _passwordController.text.isEmpty){
                    showAlert(context, "Please enter the username and password");
                    return;
                  }
                  final result = await loginViaApi(
                      _usernameController.text, _passwordController.text);
                  if (result != "") {
                    userlist = await ManagerGetUsers();
                    setState(()  {
                        username =  _usernameController.text ;
                      userlist =userlist;
                  });

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DrawerViewPage()));
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
