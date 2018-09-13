import 'package:flutter/material.dart';
import 'package:github/page/login_page.dart';
import 'package:github/page/welcome_page.dart';
import 'package:github/page/repo_list_page.dart';
import 'package:github/utils/router.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
      routes: <String, WidgetBuilder>{
        MainPageRouteName: (BuildContext context) => RepositoryListPage(),
        LoginPageRouteName: (BuildContext context) => LoginPage(),
        WelcomePageRouteName: (BuildContext context) => WelcomePage()
      },
    );
  }
}