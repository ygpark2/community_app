library total_list_response;

import 'package:json_annotation/json_annotation.dart';

part 'total_list_response.g.dart';

@JsonSerializable()
class TotalListResponse {
  final String? id;
  final String? name;
  final String? avatar;
  final String? createdAt;

  TotalListResponse({this.id, this.name, this.avatar, this.createdAt});

  factory TotalListResponse.fromJson(Map<String, dynamic> json) => _$TotalListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TotalListResponseToJson(this);
}
