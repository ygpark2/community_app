
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:commune_app/app/shared/models/response/geo_response.dart';


part 'shop.g.dart';

@JsonSerializable()
class Shop {

  @JsonKey(name: "user_id")
  final String? userId;

  @JsonKey(name: "subtitle")
  final String? subtitle;

  @JsonKey(name: "description")
  final String? description;

  @JsonKey(name: "publisher")
  final String? publisher;

  @JsonKey(name: "language")
  final String? language;

  @JsonKey(name: "categories")
  final String? categories;

  @JsonKey(name: "publishedDate")
  final String? publishedDate;

  @JsonKey(name: "title")
  final String? title;

  @JsonKey(name: "authors")
  final String? authors;

  // BuiltList<String> get tags;
  @JsonKey(name: "tags")
  final String? tags;

  @JsonKey(name: "status")
  final int? status;

  @JsonKey(name: "geo_loc")
  final GeoResponse? geoLoc;

  @JsonKey(name: "ip_address")
  final String? ipAddress;

  @JsonKey(name: "timestamp")
  final String? timestamp;

  @JsonKey(name: "version")
  final String? version;

  @JsonKey(name: "logLevel")
  final int? logLevel;


  Shop({this.userId, this.subtitle, this.description, this.publisher, this.language,
    this.categories, this.publishedDate, this.title, this.authors, this.tags,
    this.status, this.geoLoc, this.ipAddress, this.timestamp, this.version, this.logLevel});

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);

  Map<String, dynamic> toJson() => _$ShopToJson(this);
}
