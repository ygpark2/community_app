library built_geo;

import 'package:json_annotation/json_annotation.dart';

part 'geo_response.g.dart';

@JsonSerializable()
class GeoResponse {

  final double? lat;
  final double? lng;

  GeoResponse({this.lat, this.lng});

  factory GeoResponse.fromJson(Map<String, dynamic> json) => _$GeoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GeoResponseToJson(this);
}