import 'package:book_store_app/Features/Category/domain/Categoryentities.dart';

abstract class Categoryrepository {
  Future<void> createCategroy(
    final String name,
  final String description ,
  );
   Future<List<Categoryentities>> getallCategroy();
  Future<void> deleteCategroy(final String id);
  Future<Categoryentities> EditCategroy(
    final String id,
   final String name,
  final String description ,

     );

}
