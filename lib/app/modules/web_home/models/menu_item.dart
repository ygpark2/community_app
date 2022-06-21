import 'package:json_annotation/json_annotation.dart';

part 'menu_item.g.dart';

@JsonSerializable()
class MenuItem {

  int? id;

  String? textLabel;
  // The icon that appears next to the text label for the inbox.
  String? icon;


  MenuItem({this.id, this.textLabel, this.icon});

  factory MenuItem.fromJson(Map<String, dynamic> json) => _$MenuItemFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemToJson(this);

}