import 'package:book_store_app/Features/Book/domian/Bookentities.dart';

class BookModel extends Bookentities {
  final String Id;
  final String title;
  final String author;
  final String category;
  final String description;
  final double price;
  final String coverImage;
  final double rating;
  final bool featured;

  BookModel({
    required this.Id,
    required this.title,
    required this.author,
    required this.category,
    required this.description,
    required this.price,
    required this.coverImage,
    required this.rating,
    required this.featured,
  }) : super(
          Id: Id,
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
    return BookModel(
        Id: json["Id"] ?? "",
        title: json["title"]?? "",
        author: json["author"]?? "",
        category: json["category"]?? "",
        description: json["description"]?? "",
        price: json["price"]?? 0.0,
        coverImage: json["coverImage"]?? "",
        rating: json["rating"]?? 0.0,
        featured: json["featured"]?? false);
  }
}
