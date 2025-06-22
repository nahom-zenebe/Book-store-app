import 'package:book_store_app/Features/Auth/presentation/Loginpage.dart';
import 'package:book_store_app/widgets/BottomNavBar.dart';
import 'package:flutter/material.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedRole = 'user'; // Default role
  bool _isPasswordVisible = false;

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      // Handle signup logic here
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Bottomnavbar()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFf5f7fa),
              Color(0xFFc3cfe2),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo and Title
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.book,
                      size: 60,
                      color: Color(0xFF4a6fa5),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Book Haven",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4a6fa5),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Create your account",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Name Field
                  _buildTextField(
                    controller: _nameController,
                    label: "Full Name",
                    icon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Email Field
                  _buildTextField(
                    controller: _emailController,
                    label: "Email Address",
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color(0xFF4a6fa5), width: 2),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Role Selection
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8, left: 4),
                          child: Text(
                            "Select Role",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text('User'),
                                value: 'user',
                                groupValue: _selectedRole,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedRole = value!;
                                  });
                                },
                                activeColor: const Color(0xFF4a6fa5),
                                dense: true,
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text('Admin'),
                                value: 'admin',
                                groupValue: _selectedRole,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedRole = value!;
                                  });
                                },
                                activeColor: const Color(0xFF4a6fa5),
                                dense: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _handleSignup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4a6fa5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Already have an account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Loginpage()));
                        },
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                            color: Color(0xFF4a6fa5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4a6fa5), width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
    );
  }
}
