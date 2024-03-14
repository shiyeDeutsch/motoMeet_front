import 'package:isar/isar.dart';
part 'userModel.g.dart';

@collection
class UserInfo {
  final Id? id;
  final String email;
  final String? password;
  final String firstName;
  final String lastName;
  final int age;
  final String? bio;
  final int countryId;
  final String? token;
  UserInfo({
    this.id,
    required this.email,
     this.password,
    required this.firstName,
    required this.lastName,
    required this.age,
    this.bio,
    required this.countryId,
    this.token,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] as Id?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    //password: json['password'] as String?,
      email: json['email'] as String,
      bio: json['bio'] as String?,
      age: -1,//json['Age'] as int,
      countryId: json['countryId'] as int,
      token: json['token'] as String?,
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'countryId': countryId,
        'age': age,
        'bio': bio,
        'token': token
      };

  UserInfo copyWith(
      {Id? id,
      String? email,
      String? password,
      String? firstName,
      String? lastName,
      int? age,
      String? bio,
      int? countryId,
      String? token}) {
    return UserInfo(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      bio: bio ?? this.bio,
      countryId: countryId ?? this.countryId,
      token: token ?? this.token,
    );
  }
}
