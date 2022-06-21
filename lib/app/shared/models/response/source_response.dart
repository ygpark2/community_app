library source_response;

import 'package:json_annotation/json_annotation.dart';
import 'package:commune_app/app/modules/board/models/shop.dart';

part 'source_response.g.dart';

@JsonSerializable()
class SourceResponse<T> {

  @JsonKey(name: "_index")
  final String? index;
  @JsonKey(name: '_type')
  final String? type;
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: '_score')
  final double? score;

  @JsonKey(name: '_source')
  @_Converter()
  final T? source;

  SourceResponse({this.index, this.type, this.id, this.score, this.source});

  factory SourceResponse.fromJson(Map<String, dynamic> json) => _$SourceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SourceResponseToJson(this);

}


class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic> &&
        json.containsKey('user_id') &&
        json.containsKey('authors') &&
        json.containsKey('language')) {
      return Shop.fromJson(json) as T;
    }
    /*
    if (json is Map<String, dynamic> &&
        json.containsKey('name') &&
        json.containsKey('lastname')) {
      return Person.fromJson(json) as T;
    }
     */
    // This will only work if `json` is a native JSON type:
    //   num, String, bool, null, etc
    // *and* is assignable to `T`.
    return json as T;
  }

  @override
  Object toJson(T object) {
    // This will only work if `object` is a native JSON type:
    //   num, String, bool, null, etc
    // Or if it has a `toJson()` function`.
    if (T is Shop) {
      return (T as Shop).toJson();
    } else {
      return (T as Shop).toJson();
    }
  }
}
