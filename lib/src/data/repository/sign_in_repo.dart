import 'package:dio/dio.dart';

import '../datasource/remote/api_server.dart';

class SignInRepo {
  ApiService apiService;

  SignInRepo(this.apiService);

  Future<Response> postData(dynamic data) async {
    final response = await apiService.post('login', data: data);
    return response;
  }
}
