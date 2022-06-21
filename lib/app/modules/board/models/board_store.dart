import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:commune_app/app/modules/board/models/board_item_store.dart';

part 'board_store.g.dart';

@JsonSerializable()
class BoardStore {
  late final int? id;
  late final String? title;
  late final double? amount;
  late final int? qtItems;
  late final bool? selected;
  late final List<BoardItemStore> items;

  BoardStore({
    this.id,
    this.title,
    this.amount,
    this.qtItems,
    this.selected,
    required this.items
  });

  factory BoardStore.fromJson(Map<String, dynamic> json) => _$BoardStoreFromJson(json);
  Map<String, dynamic> toJson() => _$BoardStoreToJson(this);

}
