import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:commune_app/app/shared/models/search/security/password.dart';
import 'package:retrofit/http.dart';
import 'package:commune_app/app/modules/board/models/board_store.dart';
import 'package:commune_app/app/modules/board/models/shop.dart';
import 'package:commune_app/app/shared/models/response/hits_response.dart';
import 'package:commune_app/app/shared/models/response/search_list_response.dart';
import 'package:commune_app/app/shared/models/response/source_response.dart';

part 'opensearch_security_service.g.dart';

@RestApi(baseUrl: "http://localhost:10000")
abstract class OpensearchSecurityService {

  factory OpensearchSecurityService(Dio dio, {String baseUrl}) = _OpensearchSecurityService;

  // GET _opendistro/_security/api/account
  @GET('/_opendistro/_security/api/account')
  Future<String> getAccount();

  /*
  PUT _opendistro/_security/api/account
{
    "current_password" : "old-password",
    "password" : "new-password"
}
   */
  @PUT('/_opendistro/_security/api/account')
  Future<String> setPassword(@Body() Password password);
}
