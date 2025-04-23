import 'dart:convert';
import 'package:book_store_app/Features/Category/data/Categorymodel.dart';
import 'package:book_store_app/Features/Category/domain/Categoryentities.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "http://localhost:5000/api";

class Categorydatasource {
  Future<void> createCategory(String name, String description) async {
    try {
      final response = await http.post(Uri.parse("$baseUrl/createcatgory"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({"name": name, "description": description}));
      if (response.statusCode == 201) {
        print("Created successfullly");
      } else {
        throw Exception("Error in creating product");
      }
    } catch (error) {
      print(error);
    }
  }

  Future<List<Categorymodel>> getallCategory() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/getallcatgory"));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((category) => Categorymodel.fromjson(category))
            .toList();
      } else {
        throw Exception("Error in getting categories");
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

    Future<void> deleteCategory(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/deleteCategory/$id"),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 204) {
        print("Delete sucessfully");
      } else {
        throw Exception("Error in get all Books");
      }
    } catch (error) {
      print(error);
    }
  }

Future<Categoryentities> editCategory(String id, String name, String description) async {
  try {
    final response = await http.put(
      Uri.parse("$baseUrl/editcategory"), 
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "id": id,
        "name": name,
        "description": description
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Categorymodel.fromjson(data); 
    } else {
      throw Exception("Error in editing category");
    }
  } catch (error) {
    print("Error: $error");
    throw Exception("Something went wrong while editing the category.");
  }
}


  
}
