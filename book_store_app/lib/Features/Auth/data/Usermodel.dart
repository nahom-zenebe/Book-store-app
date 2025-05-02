import 'package:book_store_app/Features/Auth/domain/Userentites.dart';
import 'package:flutter/foundation.dart';

class Usermodel extends Userentites {
  final String name;
  final String email;
  final String password;
  final String role;

  Usermodel(
      {required this.email,
      required this.name,
      required this.password,
      required this.role})
      : super(email: email, name: name, role: role, password: password);

  factory Usermodel.fromjson(Map<String, dynamic> json) {
    return Usermodel(
        email: json["email"]??"",
        name: json["name"]??"",
        password: json["password"]??"",
        role: json['role']??"");
  }
}
