import 'package:dio/dio.dart';

class ResultData<T> {
  T data;

  DioError error;

  ResultData(this.data, this.error);
}
