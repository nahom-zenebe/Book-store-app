import 'dart:convert';
import 'package:book_store_app/Features/Auth/data/Usermodel.dart';
import 'package:book_store_app/Features/Auth/domain/Userentites.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "http://localhost:5000/api";

class Userdatalayer {
  Future<Userentites?> signup(String name, String email, String password, String role) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/signup"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'role': role,
        }),
      );

      if (response.statusCode == 201) {
        final dynamic user = jsonDecode(response.body);
        return Usermodel.fromjson(user);
      } else {
        print('Signup failed: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Signup error: $error');
      return null;
    }
  }

  Future<Userentites?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email, 
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        final dynamic user = jsonDecode(response.body);
        return Usermodel.fromjson(user);
      } else {
        print('Login failed: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Login error: $error');
      return null;
    }
  }

  Future<void> logout() async {
    try {
     
      print("User logged out.");
    } catch (error) {
      print("Logout error: $error");
    }
  }
}
