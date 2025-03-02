import 'package:dio/dio.dart';

String baseUrl = 'https://potterapi-fedeperin.vercel.app';
const _duration = Duration(seconds: 30);

class DioSettings {
  final Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    sendTimeout: _duration,
    connectTimeout: _duration,
    receiveTimeout: _duration,
  ));

  AppDio() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          print('#########');
          print('ON REQUEST');
          print('${options.method}: ${options.uri}');
          print('contentType : ${options.contentType}');
          print('response type : ${options.responseType}');
          print('connectTimeout : ${options.connectTimeout}');
          print('sendTimeout : ${options.sendTimeout}');
          print('extra : ${options.extra}');
          print('headers : ${options.headers}');
          print('query params : ${options.queryParameters}');
          print('data : ${options.data}');

          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          print('#########');
          print('ON RESPONSE');
          print('status code : ${response.statusCode}');
          print('real Uri : ${response.realUri}');
          print('request options : ${response.requestOptions}');
          print('extra : ${response.extra}');
          print('data : ${response.statusMessage}');
          print('data : ${response.data}');
          return handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) {
          // Do something with response error.
          // If you want to resolve the request with some custom data,
          // you can resolve a `Response` object using `handler.resolve(response)`.
          return handler.next(error);
        },
      ),
    );
  }
}
