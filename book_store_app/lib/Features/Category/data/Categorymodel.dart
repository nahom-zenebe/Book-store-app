import 'package:book_store_app/Features/Category/domain/Categoryentities.dart';
import 'package:flutter/foundation.dart';

class Categorymodel extends Categoryentities {
  final String id;
  final String name;
  final String description;

  Categorymodel(
      {required this.id, required this.name, required this.description})
      : super(id: id, name: name, description: description);

  factory Categorymodel.fromjson(Map<String, dynamic> json) {
    return Categorymodel(
        id: json['id'], name: json["name"], description: json["description"]);
  }
}
