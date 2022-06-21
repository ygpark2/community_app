// GENERATED CODE - DO NOT MODIFY BY HAND

part of shards_response;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShardsResponse<T> _$ShardsResponseFromJson<T>(Map<String, dynamic> json) {
  return ShardsResponse<T>(
    total: json['total'] as int?,
    successful: json['successful'] as int?,
    skipped: json['skipped'] as int?,
    failed: json['failed'] as int?,
  );
}

Map<String, dynamic> _$ShardsResponseToJson<T>(ShardsResponse<T> instance) =>
    <String, dynamic>{
      'total': instance.total,
      'successful': instance.successful,
      'skipped': instance.skipped,
      'failed': instance.failed,
    };
