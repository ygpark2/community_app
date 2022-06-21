// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardStore _$BoardStoreFromJson(Map<String, dynamic> json) {
  return BoardStore(
    id: json['id'] as int?,
    title: json['title'] as String?,
    amount: (json['amount'] as num?)?.toDouble(),
    qtItems: json['qtItems'] as int?,
    selected: json['selected'] as bool?,
    items: (json['items'] as List<dynamic>)
        .map((e) => BoardItemStore.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BoardStoreToJson(BoardStore instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'amount': instance.amount,
      'qtItems': instance.qtItems,
      'selected': instance.selected,
      'items': instance.items,
    };
