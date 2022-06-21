// GENERATED CODE - DO NOT MODIFY BY HAND

part of built_password;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Password _$PasswordFromJson(Map<String, dynamic> json) {
  return Password(
    currentPassword: json['currentPassword'] as String?,
    password: json['password'] as String?,
  );
}

Map<String, dynamic> _$PasswordToJson(Password instance) => <String, dynamic>{
      'currentPassword': instance.currentPassword,
      'password': instance.password,
    };
