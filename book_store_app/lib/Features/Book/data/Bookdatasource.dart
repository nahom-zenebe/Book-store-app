import 'dart:convert';

import 'package:book_store_app/Features/Book/data/Bookmodel.dart';
import 'package:book_store_app/Features/Book/domian/Bookentities.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "http://localhost:5000/api";

class Bookdatasource {
  Future<void> createBook(
    String title,
    String author,
    String category,
    String description,
    double price,
    String coverImage,
    double rating,
    bool featured,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/books/createrouter"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'title': title,
          'author': author,
          'category': category,
          'description': description,
          'price': price,
          'coverImage': coverImage,
          'rating': rating,
          'featured': featured,
        }),
      );

      if (response.statusCode == 201) {
        print("Book created successfully");
      } else {
        print("Failed to create book. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Error in creating book");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  Future<List<Bookentities>> getallBook() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/books/getallrouter"));

final List<dynamic> data = jsonDecode(response.body);


      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data.map((Books) => BookModel.fromjson(Books)).toList();
      } else {
        throw Exception("Error in get all Books");
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<void> deleteBooks(String BookId) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/deleteBooks/$BookId"),
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


  Future<Bookentities?> getbyIdBook(String Id) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/getallbook/$Id"));

      if (response.statusCode == 200) {
        print('newkdnekwfnmew');
        return null;
      } else {
        throw Exception("Error in get all Books");
      }
    } catch (error) {
      print(error);
    }
  }
  @override

Future<List<Bookentities>> searchBooks(String bookInfo) async {

  final response = await http.get(Uri.parse('$baseUrl/books/searchbooks/?bookinfo=$bookInfo'));

  if (response.statusCode == 200) {
    final List decoded = jsonDecode(response.body);
    return decoded.map((e) => BookModel.fromjson(e)).toList();
  } else {
    throw Exception('Failed to search books');
  }
}





  /*Future<BookEntity> updateBook(
  {
    required String title,
    required String author,
    required String category,
    required String description,
    required double price,
    required String coverImage,
    required double rating,
    required bool featured,
  }) async {
    const String baseUrl = "http://localhost:3002/api";

    try {
      final response = await http.put(
        Uri.parse("$baseUrl/updatebook/$bookId"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'title': title,
          'author': author,
          'category': category,
          'description': description,
          'price': price,
          'coverImage': coverImage,
          'rating': rating,
          'featured': featured,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return BookModel.fromjson(data).toString();
      } else {
        print("Failed to update book. Status code: ${response.statusCode}");
        throw Exception("Failed to update book");
      }
    } catch (error) {
      print("Error updating book: $error");
      rethrow;
    }
  }*/
}
