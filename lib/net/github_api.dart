import 'dart:convert';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:github/model/repository.dart';
import 'package:github/model/result_data.dart';
import 'package:github/utils/storage.dart';

class GithubApi {
  static final GithubApi _singleton = new GithubApi._init();

  static Dio _dio;

  factory GithubApi() {
    if (_dio == null) {
      Options options = Options(baseUrl: "https://api.github.com");
      options.headers["Accept"] = "application/vnd.github.v3+json";
      _dio = Dio(options);
    }
    return _singleton;
  }

  GithubApi._init();

  static Options _option = Options();

  setAuth(String auth) {
    _option.headers["Authorization"] = auth;
  }

  //验证用户名和密码
  Future<ResultData> login(String email, String password) async {
    try {
      String credentials = email + ":" + password;
      var bytes = utf8.encode(credentials);
      final authorization = "Basic " + base64.encode(bytes);
      Storage.save(BasicAuthKey, authorization);
      _option.headers["Authorization"] = authorization;

      var response = await _dio.get("/user", options: _option);
      return ResultData(response, null);
    } on DioError catch (e) {
      return ResultData(null, e);
    }
  }

  //获取自己的仓库列表
  Future<ResultData<List<Repository>>> fetchSelfRepositories() async {
    try {
      Response response = await _dio.get("/user/repos?visibility=all&affiliation=owner&sort=updated", options: _option);

      List<Repository> repList = List();
      var list = response.data as List;

      list.forEach((item) {
        var repo = item as Map;
        var rep = Repository();
        rep.name = repo["name"];
        rep.description = repo["description"];
        rep.language = repo["language"];
        rep.starCount = repo["stargazers_count"];
        rep.htmlUrl = repo["html_url"];
        Owner owner = Owner();
        owner.name = (repo['owner'] as Map)["login"];
        owner.avatarUrl = (repo['owner'] as Map)["avatar_url"];
        rep.owner = owner;
        repList.add(rep);
      });

      return ResultData(repList, null);
    } on DioError catch (e) {
      return ResultData(null, e);
    }
  }
}
