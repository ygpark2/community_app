library hits_response;

import 'package:json_annotation/json_annotation.dart';
import 'package:commune_app/app/shared/models/response/source_response.dart';
import 'package:commune_app/app/shared/models/response/total_list_response.dart';

part 'hits_response.g.dart';

@JsonSerializable()
class HitsResponse<T> {

  final TotalListResponse? total;

  @JsonKey(name: "max_score")
  final double? maxScore;

  @JsonKey(name: "hits")
  @_Converter()
  // final List<T>? hits;
  final List<SourceResponse>? hits;
  // T get hits;

  HitsResponse({this.total, this.maxScore, this.hits});

  factory HitsResponse.fromJson(Map<String, dynamic> json) => _$HitsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HitsResponseToJson(this);
}

class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic> &&
        json.containsKey('_index') &&
        json.containsKey('_score')) {
          return SourceResponse<T>.fromJson(json) as T;
        };
    if (json is List<dynamic>) {
      print("========================== list dynamic ===================");
      json.map((e) {
        print(e);
        print("-----------------------------------------");
        var element = e as Map<String, dynamic>;
        if (element.containsKey('_index') &&
            element.containsKey('_score')) {
          return SourceResponse.fromJson(e);
        }
      });
      return json as T;
    };
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
    return (T as SourceResponse).toJson();
  }
}

