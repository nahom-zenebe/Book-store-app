import 'package:book_store_app/Features/Book/domian/Bookentities.dart';
import 'package:equatable/equatable.dart';

 class Cartstate {
  final List<Bookentities> Books;
  const Cartstate({this.Books = const []});

  double get totalPrice => Books.fold(0, (sum, item) => sum + item.price);
}
