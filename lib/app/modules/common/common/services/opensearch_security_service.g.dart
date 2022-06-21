// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opensearch_security_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _OpensearchSecurityService implements OpensearchSecurityService {
  _OpensearchSecurityService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://localhost:10000';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<String> getAccount() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<String>(_setStreamType<String>(
        Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/_opendistro/_security/api/account',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<String> setPassword(password) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(password.toJson());
    final _result = await _dio.fetch<String>(_setStreamType<String>(
        Options(method: 'PUT', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/_opendistro/_security/api/account',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
