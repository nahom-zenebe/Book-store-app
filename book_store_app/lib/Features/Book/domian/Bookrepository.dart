import 'package:book_store_app/Features/Book/domian/Bookentities.dart';

abstract class Bookrepository {

  Future<void> createBook(final String title,
  final String author,
  final String category,
  final String description,
  final double price,
  final String coverImage,
  final double rating,
  final bool featured,);
  Future<List<Bookentities>> getallBook();
  Future<Bookentities> getbyIdBook(String Id);
  Future<void> DeleteBooks(String Id);
  Future<Bookentities> UpdateBook(String Id,final String title,
  final String author,
  final String category,
  final String description,
  final double price,
  final String coverImage,
  final double rating,
  final bool featured,);
}
