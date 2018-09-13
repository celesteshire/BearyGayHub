import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:github/model/repository.dart';
import 'package:github/net/github_api.dart';
import 'package:github/page/login_page.dart';

class RepositoryListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RepositoryListPageState();
}

enum MenuItems { LoginOut, ExitApp }

class RepositoryListPageState extends State<RepositoryListPage> {
  List<Repository> items = List();

  var loading = true;

  @override
  void initState() {
    super.initState();
    uploadData();
  }

  Future<Null> uploadData() async {
    var resultData = await GithubApi().fetchSelfRepositories();
    setState(() {
      items = resultData.data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fultter Github"),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (MenuItems item) {
                switch (item) {
                  case MenuItems.LoginOut:

                    //这里需要删除 token

                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
                      return LoginPage();
                    }));
                    break;
                  case MenuItems.ExitApp:
                    exit(0);
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItems>>[
                    const PopupMenuItem(value: MenuItems.LoginOut, child: Text("登出账号")),
                    const PopupMenuItem(value: MenuItems.ExitApp, child: Text("退出应用"))
                  ],
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Offstage(
              offstage: !loading,
              child: Column(children: <Widget>[Padding(padding: EdgeInsets.all(10.0)), CircularProgressIndicator()]),
            ),
            Expanded(
                child: RefreshIndicator(
                    child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[ListTile(title: Text(items[index].name)), Divider()],
                          );
                        }),
                    onRefresh: uploadData)),
          ],
        ));
  }
}
