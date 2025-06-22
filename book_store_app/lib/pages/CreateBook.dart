import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateBook extends StatefulWidget {
  const CreateBook({super.key});

  @override
  State<CreateBook> createState() => _CreateBookState();
}

class _CreateBookState extends State<CreateBook> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _coverImageController = TextEditingController();
  final TextEditingController _featuredImageController = TextEditingController();

  String selectedBookType = "Regular";
  String? _coverImagePath;

  void validateForm() {
    if (formKey.currentState!.validate()) {
      // Send data to Bloc
      /* BlocProvider.of<BookBloc>(context).add(
        CreateBookEvent(
          title: _titleController.text,
          author: _authorController.text,
          category: _categoryController.text,
          description: _descriptionController.text,
          price: double.parse(_priceController.text),
          coverImage: _coverImagePath ?? '',
          featuredImage: _featuredImageController.text,
          bookType: selectedBookType,
        ),
      ); */
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Book created successfully!')),
      );
    }
  }

  Future<void> _pickCoverImage() async {
    // In a real app, you would implement image picking here
    // For demo purposes, we'll just simulate it
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _coverImagePath = 'https://via.placeholder.com/300x400';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Book", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover Image Upload
              Center(
                child: GestureDetector(
                  onTap: _pickCoverImage,
                  child: Container(
                    width: 200,
                    height: 280,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300, width: 1.5),
                    ),
                    child: _coverImagePath == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_photo_alternate_outlined, 
                                  size: 50, color: Colors.grey.shade400),
                              const SizedBox(height: 10),
                              Text("Add Cover Image", 
                                  style: TextStyle(color: Colors.grey.shade600)),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              _coverImagePath!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              // Book Type Dropdown
              Text("Book Type", style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedBookType,
                items: ['Regular', 'Featured']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                onChanged: (value) {
                  setState(() {
                    selectedBookType = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              
              // Title
              buildTextField(_titleController, "Title"),
              const SizedBox(height: 15),
              
              // Author
              buildTextField(_authorController, "Author"),
              const SizedBox(height: 15),
              
              // Category
              buildTextField(_categoryController, "Category"),
              const SizedBox(height: 15),
              
              // Description
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                validator: (value) => value!.isEmpty ? "Description is required" : null,
                decoration: InputDecoration(
                  labelText: "Description",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
              ),
              const SizedBox(height: 15),
              
              // Price
              buildTextField(_priceController, "Price", isNumber: true),
              const SizedBox(height: 30),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: validateForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
            
                  ),
                  
                  
                ),
                child: Text("Post"),
              ),
           
            )
          ])
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label,
      {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      validator: (value) => value!.isEmpty ? "$label is required" : null,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }
}