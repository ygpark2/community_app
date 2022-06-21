// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_item_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardItemStore _$BoardItemStoreFromJson(Map<String, dynamic> json) {
  return BoardItemStore(
    id: json['id'] as int?,
    qt: json['qt'] as String?,
    name: json['name'] as String?,
    value: json['value'] as String?,
    error: json['error'] as String?,
  );
}

Map<String, dynamic> _$BoardItemStoreToJson(BoardItemStore instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qt': instance.qt,
      'name': instance.name,
      'value': instance.value,
      'error': instance.error,
    };
