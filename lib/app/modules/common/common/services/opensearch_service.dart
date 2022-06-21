import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:commune_app/app/modules/board/models/board_store.dart';
import 'package:commune_app/app/modules/board/models/shop.dart';
import 'package:commune_app/app/shared/models/response/hits_response.dart';
import 'package:commune_app/app/shared/models/response/search_list_response.dart';
import 'package:commune_app/app/shared/models/response/source_response.dart';

part 'opensearch_service.g.dart';

@RestApi(baseUrl: "http://localhost:10000")
abstract class OpensearchService {

  factory OpensearchService(Dio dio, {String baseUrl}) = _OpensearchService;

  @GET('/_cat/nodes')
  Future<String> getNodes();


  @GET('/_cat/health')
  Future<String> getHealth();
  // GET _cat/health?v

  // GET _cat/indices?v
  @GET('/_cat/indices')
  Future<String> getIndices();

  // GET _cat/master?v
  @GET('/_cat/master')
  Future<String> getMaster();

  // GET _cat/nodeattrs?v
  @GET('/_cat/nodeattrs')
  Future<String> getNodeattrs();

  // GET _cat/pending_tasks?v
  @GET('/_cat/pending_tasks')
  Future<String> getPendingTasks();

  // GET _cat/plugins?v
  @GET('/_cat/plugins')
  Future<String> getPlugins();

  // GET _cat/recovery?v
  @GET('/_cat/recovery')
  Future<String> getRecovery();

  // GET _cat/repositories?v
  @GET('/_cat/repositories')
  Future<String> getRepositories();

  // GET _cat/segments?v
  @GET('/_cat/segments')
  Future<String> getSegments();

  // GET _cat/segments/<index>?v
  @GET('/_cat/segments/{index}')
  Future<String> getIndexSegments(@Path('index') String index);

  // GET _cat/shards?v
  @GET('/_cat/shards')
  Future<String> getShards();

  // GET _cat/shards/<index>?v
  @GET('/_cat/shards/{index}')
  Future<String> getIndexShards(@Path('index') String index);

  // GET _cat/snapshots/<repository>?v
  @GET('/_cat/snapshots/{repository}')
  Future<String> getSnapshots(@Path('repository') String repository);

  // GET _cat/tasks?v
  @GET('/_cat/tasks')
  Future<String> getTasks();

  // GET _cat/templates?v
  @GET('/_cat/templates')
  Future<String> getTemplates();

  // GET _cat/thread_pool?v
  @GET('/_cat/thread_pool')
  Future<String> getThreadPool();

}
