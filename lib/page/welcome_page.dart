import 'package:flutter/material.dart';
import 'dart:async';
import 'package:github/utils/storage.dart';
import 'package:github/utils/router.dart';
import 'package:github/net/github_api.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WelcomePageState();
  }
}

class _WelcomePageState extends State<WelcomePage> {
  var initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (initialized == true) {
      return;
    }
    initialized = true;
    Future.delayed(Duration(seconds: 1), () {
      Storage.getString(BasicAuthKey).then((res) {
        if (res == null) {
          Navigator.pushReplacementNamed(context, LoginPageRouteName);
        } else {
          GithubApi().setAuth(res);
          Navigator.pushReplacementNamed(context, MainPageRouteName);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hello flutter")
      ),
    );
  }
}