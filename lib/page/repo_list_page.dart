import 'package:flutter/material.dart';
import 'package:github/model/repository.dart';
import 'package:github/net/github_api.dart';

class RepositoryListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RepositoryListPageState();
}

class RepositoryListPageState extends State<RepositoryListPage> {
  List<Repository> items = List();

  @override
  void initState() {
    super.initState();

    GithubApi().fetchSelfRepositories().then((data) {
      setState(() {
        items = data.data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Fultter Github")),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(items[index].name));
            }));
  }
}
