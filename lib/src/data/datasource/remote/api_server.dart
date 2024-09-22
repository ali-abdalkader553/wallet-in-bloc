import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  String baseUrl="http://127.0.0.1:8000/api/";

  ApiService() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 100);



    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {

        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        return handler.next(e);
      },
    ));
  }


  Future<Response> post(String path,
      {required dynamic data, Map<String, dynamic>? queryParameters}) async {
    Response? response ;
    try{
       response =
          await _dio.post(path, data: data, queryParameters: queryParameters);
    }catch(e){
      print('/////////////////////////////////////////// test ');
    }
    return response! ;
  }
}