import 'package:json_annotation/json_annotation.dart';

part 'register_model.g.dart';

@JsonSerializable()
class RegisterModel {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final int age;
  final int countryId;
  final DateTime? dateOfBirth;

  RegisterModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.age = 0,
    required this.countryId,
    this.dateOfBirth,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);

  RegisterModel copyWith({
    String? email,
    String? password,
    String? firstName,
    String? lastName,
    int? age,
    int? countryId,
    DateTime? dateOfBirth,
  }) {
    return RegisterModel(
      email: email ?? this.email,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      countryId: countryId ?? this.countryId,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }
}