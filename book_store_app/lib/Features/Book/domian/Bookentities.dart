class Bookentities {
  final String id;
  final String title;
  final String author;
  final String category;
  final String description;
  final double price;
  final String coverImage;
  final double rating;
  bool featured;

  Bookentities(

      {required this.id
        ,required this.title,
      required this.author,
      required this.category,
      required this.coverImage,
      required this.description,
      required this.featured,
      required this.price,
      required this.rating});
}
