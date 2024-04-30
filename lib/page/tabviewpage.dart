import 'package:flutter/material.dart';
import 'package:simple_login_app2/page/homepage.dart';
import 'package:simple_login_app2/page/loginpage.dart';
import 'package:simple_login_app2/page/registerPage.dart';

class TabViewPage extends StatefulWidget {
  const TabViewPage({super.key});

  @override
  State<TabViewPage> createState() => _TabViewPageState();
}

class _TabViewPageState extends State<TabViewPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            title: Text('Tab Bar Example'),
          ),
          body: TabBarView(
            children: [
              MyHomePage(title: "Hello"),
              RegisterPage(),
            ],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(text: 'HomePage'),
              Tab(text: 'RegisterPage'),
            ],
          ),
        ));
  }
}
