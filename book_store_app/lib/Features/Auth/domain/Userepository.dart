import 'package:book_store_app/Features/Auth/domain/Userentites.dart';

abstract class Userepository {
  Future<Userentites> Signup(final String name, final String email,
      final String password, final String role);

  Future<Userentites> Login(
    final String email,
    final String password,
  );
  Future<void> Logout();
}
