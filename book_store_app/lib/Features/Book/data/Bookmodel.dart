import 'package:book_store_app/Features/Book/domian/Bookentities.dart';

class BookModel extends Bookentities {
  final String id;
  final String title;
  final String author;
  final String category;
  final String description;
  final double price;
  final String coverImage;
  final double rating;
  final bool featured;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.description,
    required this.price,
    required this.coverImage,
    required this.rating,
    required this.featured,
  }) : super(
          id: id,
          title: title,
          author: author,
          category: category,
          description: description,
          price: price,
          coverImage: coverImage,
          rating: rating,
          featured: featured,
        );

 factory BookModel.fromjson(Map<String, dynamic> json) {
  String getCoverImage(dynamic coverImageData) {
    if (coverImageData is String) {
      return coverImageData;
    } else if (coverImageData is Map) {
      return coverImageData['url'] ?? ''; // or whatever field contains the URL
    }
    return '';
  }

  return BookModel(
    id: json["id"] ?? "",
    title: json["title"] ?? "",
    author: json["author"] ?? "",
    category: json["category"]["name"] ?? "",
    description: json["description"] ?? "",
    price: (json["price"] ?? 0).toDouble(),
    rating: (json["rating"] ?? 0).toDouble(),
    coverImage: getCoverImage(json['coverImage']),
    featured: json["featured"] ?? false,
  );
}
}
