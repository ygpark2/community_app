// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) {
  return MenuItem(
    id: json['id'] as int?,
    textLabel: json['textLabel'] as String?,
    icon: json['icon'] as String?,
  );
}

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
      'id': instance.id,
      'textLabel': instance.textLabel,
      'icon': instance.icon,
    };
