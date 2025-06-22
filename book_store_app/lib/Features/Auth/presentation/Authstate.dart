
import 'package:equatable/equatable.dart';
import 'package:book_store_app/Features/Auth/domain/Userentites.dart';
abstract class Authstate extends Equatable {
  const Authstate();
  
  @override
  List<Object> get props => [];
}

class AuthInitialState extends Authstate {}

class AuthloadingState extends Authstate {}

class AuthSuccessState extends Authstate {
  final String message;
  const AuthSuccessState({required this.message});
  
  @override
  List<Object> get props => [message];
}

class AuthErrortate extends Authstate {
  final String message;
  const AuthErrortate({required this.message});
  
  @override
  List<Object> get props => [message];
}

class AuthAuthenticatedState extends Authstate {
  final Userentites user;
  const AuthAuthenticatedState({required this.user});
  
  @override
  List<Object> get props => [user];
}