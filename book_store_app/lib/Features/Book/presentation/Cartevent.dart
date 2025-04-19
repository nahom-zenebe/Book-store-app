import 'package:equatable/equatable.dart';
import 'package:book_store_app/Features/Book/domian/Bookentities.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final String title;
  final String author;
  final String category;
  final String description;
  final double price;
  final String coverImage;
  final double rating;
  final bool featured;

  const AddToCart ({
    required this.title,
    required this.author,
    required this.category,
    required this.description,
    required this.price,
    required this.coverImage,
    required this.rating,
    required this.featured,
  });

  @override
  List<Object?> get props =>
      [title, author, category, description, price, coverImage, rating, featured];
}


class RemoveFromCart extends CartEvent {
  final String id;

  const RemoveFromCart({required this.id});

  @override
  List<Object?> get props => [id];
}
class ClearCart extends CartEvent {
  const ClearCart();
}
