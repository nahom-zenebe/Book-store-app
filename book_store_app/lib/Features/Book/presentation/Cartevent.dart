import 'package:book_store_app/Features/Book/domian/Bookentities.dart';
import 'package:equatable/equatable.dart';

abstract class Cartevent extends Equatable {
  const Cartevent();
  @override
  List<Object?> get props => [];
}

class Addtocart extends Cartevent {
  final Bookentities books;

  const Addtocart({required this.books});

  @override
  List<Object?> get props => [
       books
      ];
}

class Removefromcart extends Cartevent {
  final Bookentities books;
  const Removefromcart({required this.books});

  @override
  List<Object?> get props => [books];
}

class ClearCart extends Cartevent {}
