import 'package:book_store_app/Features/Auth/data/Usermodel.dart';
import 'package:book_store_app/Features/Auth/domain/Userentites.dart';
import 'package:book_store_app/Features/Auth/presentation/authevent.dart';
import 'package:book_store_app/Features/Auth/presentation/authstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthBloc extends Bloc<Authevent, Authstate> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthsignupEvent>(_onSignup);
    on<AuthloginEvent>(_onLogin);
    on<AuthlogoutEvent>(_onLogout);
  }

  Future<void> _onSignup(AuthsignupEvent event, Emitter<Authstate> emit) async {
    emit(AuthloadingState());
    const baseApi = "http://localhost:5000/api/auth";
    try {
      final response = await http.post(
        Uri.parse("$baseApi/register"),
        body: jsonEncode({
          'name': event.name,
          'email': event.email,
          'password': event.password,
          'role': event.role,
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 201) {
        emit(AuthSuccessState(message: "Signup successful"));
        final user = Usermodel.fromjson(jsonDecode(response.body));
        emit(AuthAuthenticatedState(user: user));
      } else {
        final error = jsonDecode(response.body)['message'] ?? 'Signup failed';
        emit(AuthErrortate(message: error));
      }
    } catch (error) {
      emit(AuthErrortate(message: "An error occurred: $error"));
    }
  }

  Future<void> _onLogin(AuthloginEvent event, Emitter<Authstate> emit) async {
    emit(AuthloadingState());
    const baseApi = "http://localhost:5000/api/auth";
    try {
      final response = await http.post(
        Uri.parse("$baseApi/login"),
        body: jsonEncode({
          'email': event.email,
          'password': event.password,
        }),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        emit(AuthSuccessState(message: "Login successful"));
        final user = Usermodel.fromjson(jsonDecode(response.body));
        emit(AuthAuthenticatedState(user: user));
      } else {
        final error = jsonDecode(response.body)['message'] ?? 'Login failed';
        emit(AuthErrortate(message: error));
      }
    } catch (error) {
      emit(AuthErrortate(message: "An error occurred: $error"));
    }
  }

  Future<void> _onLogout(AuthlogoutEvent event, Emitter<Authstate> emit) async {
    emit(AuthloadingState());
    const baseApi = "http://localhost:5000/api/auth";
    try {
      final response = await http.post(
        Uri.parse("$baseApi/logout"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        emit(AuthSuccessState(message: "Logout successful"));
      } else {
        final error = jsonDecode(response.body)['message'] ?? 'Logout failed';
        emit(AuthErrortate(message: error));
      }
    } catch (error) {
      emit(AuthErrortate(message: "An error occurred: $error"));
    }
  }
}