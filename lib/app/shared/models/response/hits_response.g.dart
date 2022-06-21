// GENERATED CODE - DO NOT MODIFY BY HAND

part of hits_response;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HitsResponse<T> _$HitsResponseFromJson<T>(Map<String, dynamic> json) {
  return HitsResponse<T>(
    total: json['total'] == null
        ? null
        : TotalListResponse.fromJson(json['total'] as Map<String, dynamic>),
    maxScore: (json['max_score'] as num?)?.toDouble(),
    hits: (json['hits'] as List<dynamic>?)
        ?.map((e) => SourceResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$HitsResponseToJson<T>(HitsResponse<T> instance) =>
    <String, dynamic>{
      'total': instance.total,
      'max_score': instance.maxScore,
      'hits': instance.hits,
    };
