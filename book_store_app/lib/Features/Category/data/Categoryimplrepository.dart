import 'package:book_store_app/Features/Category/data/Categorydatasource.dart';
import 'package:book_store_app/Features/Category/domain/Categoryentities.dart';
import 'package:book_store_app/Features/Category/domain/Categoryrepository.dart';

class Categoryimplrepository implements Categoryrepository {
  final Categorydatasource categorydatasource;

  Categoryimplrepository({required this.categorydatasource});

  @override
  Future<void> createCategroy(
    final String name,
    final String description,
  ) async {
    return await categorydatasource.createCategory(name, description);
  }

  @override
  Future<List<Categoryentities>> getallCategroy()async {
        return await categorydatasource.getallCategory();
  }
  @override
  Future<void> deleteCategroy(final String id)async {
        return await categorydatasource.deleteCategory(id);
  }
  @override
  Future<Categoryentities> EditCategroy(
      final String name, final String description, final String id) {
            return await categorydatasource.createCategory(name, description);
      }
}
