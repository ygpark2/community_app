// GENERATED CODE - DO NOT MODIFY BY HAND

part of search_list_response;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchListResponse<T> _$SearchListResponseFromJson<T>(
    Map<String, dynamic> json) {
  return SearchListResponse<T>(
    took: json['took'] as int?,
    timedOut: json['timed_out'] as bool?,
    shards: json['_shards'] == null
        ? null
        : ShardsResponse.fromJson(json['_shards'] as Map<String, dynamic>),
    hits: json['hits'] == null
        ? null
        : HitsResponse.fromJson(json['hits'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SearchListResponseToJson<T>(
        SearchListResponse<T> instance) =>
    <String, dynamic>{
      'took': instance.took,
      'timed_out': instance.timedOut,
      '_shards': instance.shards,
      'hits': instance.hits,
    };
