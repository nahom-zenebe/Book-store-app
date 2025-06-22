import 'package:equatable/equatable.dart';

abstract class Authevent extends Equatable {
  const Authevent();

  @override
  List<Object> get props => [];
}

class AuthsignupEvent extends Authevent {
  final String name;
  final String email;
  final String password;
  final String role;

  const AuthsignupEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  @override
  List<Object> get props => [name, email, password, role];
}

class AuthloginEvent extends Authevent {
  final String email;
  final String password;

  const AuthloginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class AuthlogoutEvent extends Authevent {}