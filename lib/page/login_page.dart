import 'package:flutter/material.dart';
import 'package:github/net/github_api.dart';
import 'package:github/page/repo_list_page.dart';

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
            child: Column(children: <Widget>[
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "邮箱"),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "密码"),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              Stack(
                children: <Widget>[
                  Center(
                    child: Builder(
                        builder: (context) => RaisedButton(
                            child: Text("登录"),
                            onPressed: () {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              login(context);
                            })),
                  ),
                  Align(
                      alignment: FractionalOffset.centerRight,
                      child: Offstage(
                        offstage: !loading,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                          child: CircularProgressIndicator(),
                        ),
                      )),
                ],
              ),
            ]),
          ),
        ));
  }

  void setLoading(bool loading) {
    setState(() {
      this.loading = loading;
    });
  }

  void login(BuildContext context) {
    var email = emailController.text;
    var password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("邮箱密码不能为空")));
      return;
    }

    setLoading(true);
    GithubApi().login(email, password).then((data) {
      setLoading(false);
      if (data.error != null) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(data.error.message)));
        return;
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return RepositoryListPage();
      }));
    });
  }
}
