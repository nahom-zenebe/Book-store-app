import 'package:equatable/equatable.dart';

abstract class Categoryevent extends Equatable {
  const Categoryevent();
  @override
  List<Object?> get props => [];
}
class AddCategory extends Categoryevent {
  final String name;
  final String description;
 

  const AddCategory({
    required this.name,
    required this.description,
 
  });

  @override
  List<Object?> get props =>
      [name,description];
}

class GetAllCategory extends Categoryevent {
  const GetAllCategory();
}

class DeleteCategory extends Categoryevent {
  final String id;

  const DeleteCategory({required this.id});

  @override
  List<Object?> get props => [id];
}

