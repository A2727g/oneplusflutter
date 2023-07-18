import 'package:json_annotation/json_annotation.dart';

part 'get_user_filter.g.dart';

@JsonSerializable()
class Person {
  /// The generated code assumes these values exist in JSON.
  final String? user_first_name,
      user_last_name,
      mobile,
      user_status,
      user_role,
      user_country,
      user_email;

  final int user_id;
  // final int user_id;

  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.
  // final DateTime? dateOfBirth;

  Person(
    this.mobile,
    this.user_status,
    this.user_role,
    this.user_country,
    this.user_email, {
    required this.user_first_name,
    required this.user_last_name,
    required this.user_id,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
