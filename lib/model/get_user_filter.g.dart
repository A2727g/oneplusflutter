// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      json['mobile'] as String?,
      json['user_status'] as String?,
      json['user_role'] as String?,
      json['user_country'] as String?,
      json['user_email'] as String?,
      user_first_name: json['user_first_name'] as String?,
      user_last_name: json['user_last_name'] as String?,
      user_id: json['user_id'] as int,
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'user_first_name': instance.user_first_name,
      'user_last_name': instance.user_last_name,
      'mobile': instance.mobile,
      'user_status': instance.user_status,
      'user_role': instance.user_role,
      'user_country': instance.user_country,
      'user_email': instance.user_email,
      'user_id': instance.user_id,
    };
