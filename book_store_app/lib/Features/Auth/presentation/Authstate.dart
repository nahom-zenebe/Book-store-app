

import 'package:book_store_app/Features/Auth/domain/Userentites.dart';

abstract class Authstate {}

class AuthInitialState extends Authstate {}

class AuthloadingState extends Authstate {}

class AuthSuccessState extends Authstate {
  final String message;
  AuthSuccessState({required this.message});
}

class AuthErrortate extends Authstate {
  final String message;
  AuthErrortate({required this.message});
}

class AuthAuthenticatedState extends Authstate {
  final Userentites user;

  AuthAuthenticatedState({required this.user});
}