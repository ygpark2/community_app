import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:commune_app/app/modules/common/core/local/shared_pref_helper.dart';


class LoggingInterceptor extends Interceptor {
  int _maxCharactersPerLine = 200;
  late SharedPrefHelper sharedPrefHelper;

  LoggingInterceptor() {
    sharedPrefHelper = Modular.get<SharedPrefHelper>();
    print("============= login intercepter =================");
    _getToken().then((value) => sharedPrefHelper.setValueToken(value));
  }

  Future<String> _getToken() async {
    final jwt = JWT(
      {
        "roles": ["admin", "all_access"],
        "exp": DateTime.now().add( Duration(days: 1) ).millisecondsSinceEpoch,
        "iat": DateTime.now().millisecondsSinceEpoch
      },
      subject: "admin",
      issuer: 'https://localhost',
    );

    // Sign it
    String privateKey = await rootBundle.loadString('keys/id_ecdsa');
    print(privateKey);
    print("--------------------------------------------------");
    final key = ECPrivateKey(privateKey);

    final token = jwt.sign(key, algorithm: JWTAlgorithm.ES256);
    return token.toString();
  }

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await sharedPrefHelper.getValueToken();
    Map<String, dynamic> headers = Map();
    if (token != null) {
      headers["Authorization"] = "Bearer $token";
    }
    options.headers.addAll(headers);
    print("--> ${options.method} ${options.baseUrl}${options.path}");
    print("params: ${options.queryParameters}");
    print("<-- END HTTP");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        "<--response: ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");
    String responseAsString = response.data.toString();
    if (responseAsString.length > _maxCharactersPerLine) {
      int iterations =
          (responseAsString.length / _maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        print(
            responseAsString.substring(i * _maxCharactersPerLine, endingIndex));
      }
    } else {
      print(response.data);
    }
    print("<-- END HTTP");

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print("<-- Error -->");
    print(err.error);
    print(err.message);
    super.onError(err, handler);
  }

}
