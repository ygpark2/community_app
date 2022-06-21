library built_password;

import 'package:json_annotation/json_annotation.dart';

part 'password.g.dart';

@JsonSerializable()
class Password {

  /*
  {
    "current_password" : "old-password",
    "password" : "new-password"
}
   */
  final String? currentPassword;
  final String? password;

  Password({this.currentPassword, this.password});

  factory Password.fromJson(Map<String, dynamic> json) => _$PasswordFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordToJson(this);
}