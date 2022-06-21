// GENERATED CODE - DO NOT MODIFY BY HAND

part of built_geo;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoResponse _$GeoResponseFromJson(Map<String, dynamic> json) {
  return GeoResponse(
    lat: (json['lat'] as num?)?.toDouble(),
    lng: (json['lng'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$GeoResponseToJson(GeoResponse instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
