

import 'package:book_store_app/Features/Category/domain/Categoryrepository.dart';
import 'package:book_store_app/Features/Category/presentation/Categoryevent.dart';
import 'package:book_store_app/Features/Category/presentation/Categorystate.dart';
import 'package:book_store_app/Features/Category/presentation/Categorystate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cateogorybloc extends Bloc<Categoryevent, Categorystate> {
  final Categoryrepository categoryrepository;

  Cateogorybloc(this.categoryrepository) : super(const CategoryInitial()) {
    on<GetAllCategory>(_onGetAllCategorys);
    on<AddCategory>(_onAddCategory);
    on<DeleteCategory>(_onDeleteCategory);
  }

  Future<void> _onGetAllCategorys(
      GetAllCategory event, Emitter<Categorystate> emit) async {
    emit(const CategoryLoading());
    try {
      final Categorys = await categoryrepository.getallCategroy();
      emit(CategoryLoaded(Categorys));
    } catch (error) {
      emit(const CategoryError("Failed to load Categorys"));
    }
  }

  Future<void> _onAddCategory(AddCategory event, Emitter<Categorystate> emit) async {
  emit(const CategoryLoading());
  try {
    

    await categoryrepository.createCategroy(event.name,event.description); 

    final Categorys = await categoryrepository.getallCategroy();
    emit(CategoryLoaded(Categorys));
  } catch (error) {
    emit(const CategoryError("Failed to add Category"));
  }
}


  Future<void> _onDeleteCategory(DeleteCategory event, Emitter<Categorystate> emit) async {
    emit(const CategoryLoading());
    try {
      await  categoryrepository.deleteCategroy(event.id);
      final Categorys = await categoryrepository.getallCategroy();
      emit(CategoryLoaded(Categorys));
    } catch (error) {
      emit(const CategoryError("Failed to delete Category"));
    }
  }
}
