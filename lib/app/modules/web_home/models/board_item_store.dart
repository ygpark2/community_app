import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'board_item_store.g.dart';

@JsonSerializable()
class BoardItemStore {

  late final int? id;
  late final String? qt;
  late final String? name;
  late final String? value;
  late final String? error;

  BoardItemStore({
    this.id,
    this.qt,
    this.name,
    this.value,
    this.error
  });

  factory BoardItemStore.fromJson(Map<String, dynamic> json) => _$BoardItemStoreFromJson(json);
  Map<String, dynamic> toJson() => _$BoardItemStoreToJson(this);
}
