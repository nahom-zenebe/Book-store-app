import 'package:equatable/equatable.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object?> get props => [];
}

class AddBook extends BookEvent {
  final String title;
  final String author;
  final String category;
  final String description;
  final double price;
  final String coverImage;
  final double rating;
  final bool featured;

  const AddBook({
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

class GetAllBooks extends BookEvent {
  const GetAllBooks();
}

class DeleteBook extends BookEvent {
  final String id;

  const DeleteBook({required this.id});

  @override
  List<Object?> get props => [id];
}
