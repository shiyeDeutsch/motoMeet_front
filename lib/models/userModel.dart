import 'package:isar/isar.dart';
    part 'userModel.g.dart';

@collection
class UserInfo {
  final Id? id;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final int age;
  final String? bio;
  final int countryId;

  UserInfo({
    this.id,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.age,
    this.bio,
    required this.countryId,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['Id'] as Id?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      bio: json['bio'] as String?,
      age: json['age'] as int,
      countryId: json['countryId'] as int,
    );
  }
  Map<String, dynamic> toJson() => {
       'Id': id,
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'countryId': countryId,
        'age': age,
        'bio': bio,
      };
      
  UserInfo copyWith({
    Id? id,
    String? email,
    String? password,
    String? firstName,
    String? lastName,
    int? age,
    String? bio,
    int? countryId,
  }) {
    return UserInfo(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      bio: bio ?? this.bio,
      countryId: countryId ?? this.countryId,
    );
  }
 
}
