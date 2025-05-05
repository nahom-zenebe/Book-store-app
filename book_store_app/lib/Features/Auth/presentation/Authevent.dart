abstract class Authevent {}

class AuthsignupEvent extends Authevent {
  final String name;
  final String email;
  final String password;
  final String role;

  AuthsignupEvent(
      {required this.name,
      required this.email,
      required this.password,
      required this.role});
}

class AuthloginEvent extends Authevent {
  final String email;
  final String password;

  AuthloginEvent({required this.email, required this.password});

}

class AuthlogoutEvent extends Authevent{}
