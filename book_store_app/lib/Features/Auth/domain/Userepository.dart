import 'package:book_store_app/Features/Auth/domain/Userentites.dart';

abstract class Userepository {
  Future<Userentites?> login(String email, String password);
  Future<Userentites?> signup(String name, String email, String password, String role);
  Future<void> logout();
}
