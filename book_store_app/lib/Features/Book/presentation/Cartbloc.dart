import 'package:book_store_app/Features/Book/domian/Bookentities.dart';
import 'package:book_store_app/Features/Book/presentation/Cartevent.dart';
import 'package:book_store_app/Features/Book/presentation/Cartstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cartbloc extends Bloc<Cartevent, Cartstate> {
  Cartbloc() : super(Cartstate()) {
    on<Addtocart>((event, emit) {
      final updateBooks = List<Bookentities>.from(state.Books)
        ..add(event.books);

      emit(Cartstate(Books: updateBooks));
    });

    on<Removefromcart>((event, emit) {
      final updatedBooks = List<Bookentities>.from(state.Books)
        ..remove(event.books);
      emit(Cartstate(Books: updatedBooks));
    });

    on<ClearCart>((evet, emit) {
      emit(Cartstate(Books: []));
    });
  }
}
