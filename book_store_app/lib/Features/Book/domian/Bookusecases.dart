import 'package:book_store_app/Features/Book/domian/Bookentities.dart';
import 'package:book_store_app/Features/Book/domian/Bookrepository.dart';

class Bookusecases {
  final Bookrepository bookrepository;

  Bookusecases({required this.bookrepository});

  Future<void> createBooks(final String title,
  final String author,
  final String category,
  final String description,
  final double price,
  final String coverImage,
  final double rating,
  final bool featured,) async {
    return await bookrepository.createBook( title,author,category,description,price,coverImage,rating,featured);
  }


  Future<List<Bookentities>> getallBook() async {
    return await bookrepository.getallBook();
  }

Future<Bookentities> getBookbyId(final String Id) async {
    return await bookrepository.getbyIdBook( Id);
  }

  Future<void> DeleteBook(final String Id) async {
    return await bookrepository.DeleteBooks( Id);
  }

  Future<Bookentities> UpdateBook(final String Id,final String title,
  final String author,
  final String category,
  final String description,
  final double price,
  final String coverImage,
  final double rating,
  final bool featured,) async {
    return await bookrepository.UpdateBook( Id,title,author,category,description,price,coverImage,rating,featured,);
  }
}
