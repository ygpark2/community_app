import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/adapter_browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:commune_app/app/modules/common/core/local/shared_pref_helper.dart';
import 'LoggingInterceptor.dart';


class DioClient {
  final String apiBaseUrl;
  final SharedPrefHelper sharedPrefHelper;

  final String rootCaData;

  DioClient({required this.rootCaData, required this.apiBaseUrl, required this.sharedPrefHelper});

  // String data = await getRootCa();

  Dio get dio => _getDio();

  Dio _getDio() {
    var username = "admin";
    var password = "admin";
    var auth = 'Basic '+base64Encode(utf8.encode('$username:$password'));
    BaseOptions options = BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: 50000,
      receiveTimeout: 30000,
      headers: <String, String>{
        // "authorization": auth,
        "Accept": "application/json",
        // "Access-Control-Allow-Origin": "*"
      }
      // headers['Accept'] = 'application/json';
    );
    Dio _dio = Dio(options);
    _dio.interceptors.add(LoggingInterceptor());
    // _dio.interceptors.addAll(<Interceptor>[_loggingInterceptor()]);

    /*
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options,
            RequestInterceptorHandler requestInterceptorHandler) {

          String authToken = _preferenceService.getAuthToken();
          if (authToken.isNotEmpty) {
            options.headers["Authorization"] = "Bearer " + authToken;
            return options;
          }
        },
      ),
    );
     */

    if (kIsWeb) {
      (_dio.httpClientAdapter as BrowserHttpClientAdapter)
        ..withCredentials = true;

      // _dio.httpClientAdapter = HttpClientAdapter;
    } else {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
            // client.badCertificateCallback =
            //     (X509Certificate cert, String host, int port) => true;
            SecurityContext sc = SecurityContext();
            List<int> bytes = utf8.encode(rootCaData);
            sc.setTrustedCertificatesBytes(bytes);
            HttpClient httpClient = HttpClient(context: sc);
            return httpClient;
            /*
            client.badCertificateCallback = (cert, host, port) {
              return true;
            };
             */
      };
    }
    return _dio;
  }

  Future<Map<String, dynamic>> handlerResponse(Future<Response> handle) async {
    try {
      Response response = await handle;
      return response.data;
    } on DioError catch (error) {
      print("res error---${error.response}");
      return _handlerError(error);
    }
  }

  void _doExpires() async {
    sharedPrefHelper.removeToken();
    Modular.to.pushReplacementNamed('/login');
  }

  Map<String, dynamic> _handlerError(error) {
    if (error is DioError) {
      DioError dioError = error;
      switch (dioError.type) {
        case DioErrorType.cancel:
          return {
            'code': 501,
            'message': "Request to API server was cancelled"
          };
        case DioErrorType.connectTimeout:
          return {'code': 502, 'message': "Connection timeout with API server"};
        case DioErrorType.other:
          return {
            'code': 503,
            'message':
            "Connection to API server failed due to internet connection"
          };
        case DioErrorType.receiveTimeout:
          return {
            'code': 504,
            'message': "Receive timeout in connection with API server"
          };
        case DioErrorType.response:
          switch(dioError.response!.statusCode) {
            case 404:
              return {
                'code': dioError.response!.statusCode,
                'message': dioError.response!.statusMessage
              };
            case 401:
              final msg = dioError.response!.data['message'] ?? "";
              if (msg.contains('token')) {
                _doExpires();
              }
              return dioError.response!.data;
            default:
              return dioError.response!.data;
          }
          break;
        case DioErrorType.sendTimeout:
          return {
            'code': 505,
            'message': "Send timeout in connection with API server"
          };
      }
    }
    return {'code': 500, 'message': "Unexpected error occured"};
  }

  Interceptor _loggingInterceptor() {
    return InterceptorsWrapper(
        onRequest: (options, handler) {
          // Do something before request is sent
          debugPrint("\n"
              "Request ${options.uri} \n"
              "-- headers --\n"
              "${options.headers.toString()} \n"
              "");
          // If you want to resolve the request with some custom data，
          // you can return a `Response` object or return `dio.resolve(data)`.
          // If you want to reject the request with a error message,
          // you can return a `DioError` object or return `dio.reject(errMsg)`
        }, onResponse: (response, handler) {
          // Do something with response data
          if (response.statusCode == 200) {
            debugPrint("\n"
                "Response ${response.requestOptions.uri} \n"
                "-- headers --\n"
                "${response.headers.toString()} \n"
                "-- payload --\n"
                "${jsonEncode(response.data)} \n"
                "");
          } else {
            debugPrint("Dio Response Status --> ${response.statusCode}");
          }
        }, onError: (error, handler) {
          // Do something with response error
          debugPrint("Dio Response Error --> $error");
        });
  }
}
