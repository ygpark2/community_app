// GENERATED CODE - DO NOT MODIFY BY HAND

part of total_list_response;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalListResponse _$TotalListResponseFromJson(Map<String, dynamic> json) {
  return TotalListResponse(
    id: json['id'] as String?,
    name: json['name'] as String?,
    avatar: json['avatar'] as String?,
    createdAt: json['createdAt'] as String?,
  );
}

Map<String, dynamic> _$TotalListResponseToJson(TotalListResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'createdAt': instance.createdAt,
    };
