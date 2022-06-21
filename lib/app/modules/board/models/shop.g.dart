// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shop _$ShopFromJson(Map<String, dynamic> json) {
  return Shop(
    userId: json['user_id'] as String?,
    subtitle: json['subtitle'] as String?,
    description: json['description'] as String?,
    publisher: json['publisher'] as String?,
    language: json['language'] as String?,
    categories: json['categories'] as String?,
    publishedDate: json['publishedDate'] as String?,
    title: json['title'] as String?,
    authors: json['authors'] as String?,
    tags: json['tags'] as String?,
    status: json['status'] as int?,
    geoLoc: json['geo_loc'] == null
        ? null
        : GeoResponse.fromJson(json['geo_loc'] as Map<String, dynamic>),
    ipAddress: json['ip_address'] as String?,
    timestamp: json['timestamp'] as String?,
    version: json['version'] as String?,
    logLevel: json['logLevel'] as int?,
  );
}

Map<String, dynamic> _$ShopToJson(Shop instance) => <String, dynamic>{
      'user_id': instance.userId,
      'subtitle': instance.subtitle,
      'description': instance.description,
      'publisher': instance.publisher,
      'language': instance.language,
      'categories': instance.categories,
      'publishedDate': instance.publishedDate,
      'title': instance.title,
      'authors': instance.authors,
      'tags': instance.tags,
      'status': instance.status,
      'geo_loc': instance.geoLoc,
      'ip_address': instance.ipAddress,
      'timestamp': instance.timestamp,
      'version': instance.version,
      'logLevel': instance.logLevel,
    };
