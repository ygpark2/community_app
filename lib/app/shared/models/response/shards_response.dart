library shards_response;

import 'package:json_annotation/json_annotation.dart';

part 'shards_response.g.dart';

@JsonSerializable()
class ShardsResponse<T> {

  final int? total;
  final int? successful;
  final int? skipped;
  final int? failed;

  ShardsResponse({this.total, this.successful, this.skipped, this.failed});

  factory ShardsResponse.fromJson(Map<String, dynamic> json) => _$ShardsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShardsResponseToJson(this);
}
