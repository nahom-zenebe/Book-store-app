import 'package:book_store_app/Features/Category/domain/Categoryentities.dart';
import 'package:book_store_app/Features/Category/domain/Categoryrepository.dart';

class Categoryusecase {
  final Categoryrepository categoryrepository;

  Categoryusecase({required this.categoryrepository});

  Future<void> createCategory(
      final String name, final String description) async {
    return await categoryrepository.createCategroy(name, description);
  }

  Future<List<Categoryentities>> getallCategory() async {
    return await categoryrepository.getallCategroy();
  }
  Future<void> deleteCategory(final String id) async {
    return await categoryrepository.deleteCategroy(id);
  }

   Future<Categoryentities> EditCategory(  final String name, final String description,final String id) async {
    return await categoryrepository.EditCategroy(name, description,id);
  }
}
