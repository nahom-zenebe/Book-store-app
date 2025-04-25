import 'package:book_store_app/Features/Book/domian/Bookrepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_store_app/Features/Book/data/BookrepostoryImp.dart';

import 'package:book_store_app/Features/Book/presentation/Bookevent.dart';
import 'package:book_store_app/Features/Book/presentation/Bookstate.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final Bookrepository repository;

  BookBloc(this.repository) : super(const BookInitial()) {
    on<GetAllBooks>(_onGetAllBooks);
    on<AddBook>(_onAddBook);
    on<DeleteBook>(_onDeleteBook);
     on<SearchBooks>(_onSearchBooks); 
    
    
  }

  Future<void> _onGetAllBooks(
      GetAllBooks event, Emitter<BookState> emit) async {
    emit(const BookLoading());
    try {
      final books = await repository.getallBook();
      emit(BookLoaded(books));
    } catch (error) {
      emit(const BookError("Failed to load books"));
    }
  }

  Future<void> _onAddBook(AddBook event, Emitter<BookState> emit) async {
    emit(const BookLoading());
    try {
      await repository.createBook(
          event.title,
          event.author,
          event.category,
          event.coverImage,
          event.rating,
          event.description,
          event.price,
          event.featured);

      final books = await repository.getallBook();
      emit(BookLoaded(books));
    } catch (error) {
      emit(const BookError("Failed to add book"));
    }
  }

  Future<void> _onDeleteBook(DeleteBook event, Emitter<BookState> emit) async {
    emit(const BookLoading());
    try {
      await repository.DeleteBooks(event.id);
      final books = await repository.getallBook();
      emit(BookLoaded(books));
    } catch (error) {
      emit(const BookError("Failed to delete book"));
    }
  }

    Future<void> _onSearchBooks(SearchBooks event, Emitter<BookState> emit) async {
  emit(const BookLoading());
  try {
    final books = await repository.SearchBooks(event.bookinfo); // Fetch matching books
    emit(BookLoaded(books)); // Show only searched results
  } catch (error) {
    emit(const BookError("Failed to search books"));
  }
}



}
