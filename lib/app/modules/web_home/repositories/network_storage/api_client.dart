import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../models/data.dart';
import 'apis.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://192.168.1.192:9200")
abstract class ApiClient {

  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(Apis.users)
  Future<ResponseData> getUsers();
}
