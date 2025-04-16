import 'package:book_store_app/Features/Book/data/Bookdatasource.dart';
import 'package:book_store_app/Features/Book/domian/Bookentities.dart';
import 'package:book_store_app/Features/Book/domian/Bookrepository.dart';

class Bookrepostoryimp implements Bookrepository {
  final Bookdatasource bookdatasource;

  Bookrepostoryimp({required this.bookdatasource});

  @override
  Future<void> createBook(
    final String title,
    final String author,
    final String category,
    final String description,
    final double price,
    final String coverImage,
    final double rating,
    final bool featured,
  ) async {
    return await bookdatasource.createBook(title, author, category, description,
        price, coverImage, rating, featured);
  }

  @override
  Future<List<Bookentities>> getallBook() async {
    return await bookdatasource.getallBook();
  }

  @override
  Future<void> DeleteBooks(String Id) async {
    return await bookdatasource.deleteBooks(Id);
  }

  /*@override
  Future<Bookentities> UpdateBook(
    
    final String title,
    final String author,
    final String category,
    final String description,
    final double price,
    final String coverImage,
    final double rating,
    final bool featured,
  ) async {
    return await bookdatasource.updateBook(
 
        title: title,
        author: author,
        category: category,
        description: description,
        price: price,
        coverImage: coverImage,
        rating: rating,
        featured: featured);
  }*/
}
