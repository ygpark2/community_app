library search_list_response;

import 'package:json_annotation/json_annotation.dart';
import 'package:commune_app/app/shared/models/response/hits_response.dart';
import 'package:commune_app/app/shared/models/response/shards_response.dart';

part 'search_list_response.g.dart';

@JsonSerializable()
class SearchListResponse<T> {

  final int? took;

  @JsonKey(name: "timed_out")
  final bool? timedOut;

  @JsonKey(name: "_shards")
  final ShardsResponse? shards;

  @_Converter()
  final HitsResponse<T>? hits;
  // final T? hits;


  SearchListResponse({this.took, this.timedOut, this.shards, this.hits});

  factory SearchListResponse.fromJson(Map<String, dynamic> json) => _$SearchListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchListResponseToJson(this);
}


class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic> &&
        json.containsKey('max_score') &&
        json.containsKey('hits')) {
      return HitsResponse<T>.fromJson(json) as T;
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
    return (T as HitsResponse).toJson();
  }
}
