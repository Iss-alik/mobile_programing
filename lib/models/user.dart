import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_application_3/models/company.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  const User({this.id, this.name, this.email, this.company});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int? id;
  final String? name;
  final String? email;
  final Company? company;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}