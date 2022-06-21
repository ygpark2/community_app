// GENERATED CODE - DO NOT MODIFY BY HAND

part of source_response;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceResponse<T> _$SourceResponseFromJson<T>(Map<String, dynamic> json) {
  return SourceResponse<T>(
    index: json['_index'] as String?,
    type: json['_type'] as String?,
    id: json['_id'] as String?,
    score: (json['_score'] as num?)?.toDouble(),
    source: _Converter<T?>().fromJson(json['_source'] as Object),
  );
}

Map<String, dynamic> _$SourceResponseToJson<T>(SourceResponse<T> instance) =>
    <String, dynamic>{
      '_index': instance.index,
      '_type': instance.type,
      '_id': instance.id,
      '_score': instance.score,
      '_source': _Converter<T?>().toJson(instance.source),
    };
