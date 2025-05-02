import 'package:book_store_app/Features/Auth/domain/Userentites.dart';
import 'package:book_store_app/Features/Auth/domain/Userepository.dart';

class Userusecase {
  final Userepository userepository;

  Userusecase({required this.userepository});

  Future<Userentites> Signup(final String name, final String email,
      final String password, final String role) async {
    return await userepository.Signup(name, email, password, role);
  }

  Future<Userentites> Login(
    final String email,
    final String password,
  ) async {
    return await userepository.Login(email, password);
  }

  Future<void> Logout(final String id) async {
    return await userepository.Logout();
  }
}
