import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../models/board_store.dart';
import '../models/shop.dart';
import 'package:commune_app/app/shared/models/response/hits_response.dart';
import 'package:commune_app/app/shared/models/response/search_list_response.dart';
import 'package:commune_app/app/shared/models/response/source_response.dart';

part 'board_api_service.g.dart';

@RestApi(baseUrl: "http://localhost:10000")
abstract class BoardApiService {

  factory BoardApiService(Dio dio, {String baseUrl}) = _BoardApiService;

  @GET('/stores-naju/_search?size=10&from=0&q=*:*')
  Future<SearchListResponse<Shop>> getShops();
  // Future<SearchListResponse<HitsResponse<List<SourceResponse<Shop>>>>> getShops();

  @GET('/_cat/nodes')
  Future<String> getNodes();

  @GET('/{id}')
  Future<BoardStore> getPost(@Path('id') int id);

  @POST('')
  Future<BoardStore> postPost(@Body() BoardStore body,);
}
