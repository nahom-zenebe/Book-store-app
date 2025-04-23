
import 'package:book_store_app/Features/Category/domain/Categoryentities.dart';
import 'package:equatable/equatable.dart';

abstract class Categorystate extends Equatable {
  const Categorystate();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends Categorystate {
  const CategoryInitial();
}

class CategoryLoading extends Categorystate {
  const CategoryLoading();
}

class CategoryLoaded extends Categorystate {
  final List<Categoryentities> Category;

  const CategoryLoaded(this.Category);

  @override
  List<Object> get props => [Category];
}
class CategorySuccess extends Categorystate {
  final String message;

  const CategorySuccess(this.message);

  @override
  List<Object> get props => [message];
}

class CategoryError extends Categorystate {
  final String message;

  const CategoryError(this.message);

  @override
  List<Object> get props => [message];
}
