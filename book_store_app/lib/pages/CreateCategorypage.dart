import 'package:book_store_app/Features/Category/presentation/Categoryevent.dart';
import 'package:book_store_app/Features/Category/presentation/Cateogorybloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Createcategorypage extends StatefulWidget {
  const Createcategorypage({super.key});

  @override
  State<Createcategorypage> createState() => _CreateCategoryPageState();
}

class _CreateCategoryPageState extends State<Createcategorypage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _handleCategoryCreate() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);
      
      final name = _nameController.text.trim();
      final description = _descriptionController.text.trim();

      context.read<Cateogorybloc>().add(
        AddCategory(name: name, description: description),
      );

      
      _formKey.currentState!.reset();
      setState(() => _isSubmitting = false);
      
      Fluttertoast.showToast(
  msg: 'Category "$name" created successfully!',
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  backgroundColor: Colors.black87,
  textColor: Colors.white,
  fontSize: 16.0,
);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Category", 
               style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Category Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Category Name',
                  hintText: 'e.g. Fiction, Science, History',
                  prefixIcon: const Icon(Icons.category),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category name';
                  }
                  if (value.length < 3) {
                    return 'Name must be at least 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter a brief description of the category',
                  prefixIcon: const Icon(Icons.description),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  if (value.length < 10) {
                    return 'Description must be at least 10 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _handleCategoryCreate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : const Text(
                        'CREATE CATEGORY',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  _formKey.currentState!.reset();
                  _nameController.clear();
                  _descriptionController.clear();
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(color: Colors.blue.shade600),
                ),
                child: const Text(
                  'CLEAR FORM',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}