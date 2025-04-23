import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = "http://localhost:5000/api";

class Categorydatasource {
  Future<void> createCategory(String name, String description) async {
    try {
      final response = await http.post(Uri.parse("$baseUrl/createcatgory"));
      if (response.statusCode == 201) {
        print("Created successfullly");
      }
    } catch (error) {}
  }
}
