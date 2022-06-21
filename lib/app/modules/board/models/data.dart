import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class ResponseData {

  int? code;
  dynamic meta;
  List<dynamic>? data;

  ResponseData({this.code, this.meta, this.data});

  factory ResponseData.fromJson(Map<String, dynamic> json) => _$ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);

}