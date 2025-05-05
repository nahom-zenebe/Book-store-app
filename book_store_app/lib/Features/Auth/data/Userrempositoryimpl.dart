import 'package:book_store_app/Features/Auth/data/userDatalayer.dart';
import 'package:book_store_app/Features/Auth/domain/Userentites.dart';
import 'package:book_store_app/Features/Auth/domain/Userepository.dart';

class UserRepositoryImpl implements Userepository {
  final Userdatalayer userdatalayer;

  UserRepositoryImpl({required this.userdatalayer});

  @override
  Future<Userentites?> signup(String name, String email, String password, String role) {
    return userdatalayer.signup(name, email, password, role);
  }

  @override
  Future<Userentites?> login(String email, String password) {
    return userdatalayer.login(email, password);
  }

  @override
  Future<void> logout() {
    return userdatalayer.logout();
  }
}