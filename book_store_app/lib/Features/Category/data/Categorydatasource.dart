import 'dart:convert';
import 'package:book_store_app/Features/Category/data/Categorymodel.dart';
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
}
