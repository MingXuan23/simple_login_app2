import 'package:flutter/material.dart';
import 'package:simple_login_app2/page/homepage.dart';
import 'package:simple_login_app2/page/registerPage.dart';

class DrawerViewPage extends StatefulWidget {
  const DrawerViewPage({super.key});

  @override
  State<DrawerViewPage> createState() => _DrawerViewPageState();
}

class _DrawerViewPageState extends State<DrawerViewPage> {
  Widget? content;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flyout Layout Example'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: Text('HomePage'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  content = MyHomePage(title: "ss");
                });
              },
            ),
            ListTile(
              title: Text('UserPage'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  content = RegisterPage();
                });

              },
            ),
          ],
        ),
      ),
      body: Center(
        child: (content == null) ? Text('Welcome to HomePage') : content,
      ),
    );
  }
}
