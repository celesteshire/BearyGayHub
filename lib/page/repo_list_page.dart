import 'package:flutter/material.dart';
import 'dart:async';
import 'package:github/model/repository.dart';
import 'package:github/net/github_api.dart';

class RepositoryListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RepositoryListPageState();
}

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
        appBar: AppBar(title: Text("Fultter Github")),
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
                            children: <Widget>[
                              ListTile(title: Text(items[index].name)),
                              Divider()
                            ],
                          );
                        }),
                    onRefresh: uploadData)),
          ],
        ));
  }
}
