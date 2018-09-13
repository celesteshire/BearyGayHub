import 'package:flutter/material.dart';
import 'package:github/net/github_api.dart';
import 'package:github/page/repo_list_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        "repo_list_page": (BuildContext context) => RepositoryListPage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Fultter Github")),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "邮箱"),
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "密码"),
                ),
                Builder(
                    builder: (context) => RaisedButton(
                        child: Text("登录"),
                        onPressed: () {
                          login(context);
                        })),
                Offstage(
                  offstage: !loading,
                  child: CircularProgressIndicator(),
                )
              ],
            ),
          ),
        ));
  }

  void setLoading(bool loading) {
    setState(() {
      this.loading = loading;
    });
  }

  void login(BuildContext context) {
    setLoading(true);

    GithubApi().login(emailController.text, passwordController.text).then((data) {
      setLoading(false);
      if (data.error != null) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(data.error.message)));
        return;
      }
      Navigator.of(context).pushReplacementNamed("repo_list_page");

//      GithubApi().fetchSelfRepositories().then((data) {
//        setLoading(false);
//        if (data.error != null) {
//          Scaffold.of(context).showSnackBar(SnackBar(content: Text(data.error.message)));
//        } else {
//          String repos = "";
//          data.data.forEach((repo) {
//            repos += "${repo.name} \n";
//          });
//          Scaffold.of(context).showSnackBar(SnackBar(content: Text(repos)));
//        }
//      });
    });
  }
}
