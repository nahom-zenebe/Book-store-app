import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Features/Book/presentation/Bookbloc.dart'; 

class Createbook extends StatefulWidget {
  const Createbook({super.key});

  @override
  State<Createbook> createState() => _CreatebookState();
}

class _CreatebookState extends State<Createbook> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _coverImageController = TextEditingController();
  final TextEditingController _featuredImageController = TextEditingController();

  String selectedBookType = "Regular"; // Default value

  void validateForm() {
    if (formKey.currentState!.validate()) {
      // Send data to Bloc
     /* BlocProvider.of<BookBloc>(context).add(
       Createbook(
          title: _titleController.text,
          author: _authorController.text,
          category: _categoryController.text,
          description: _descriptionController.text,
          price: double.parse(_priceController.text),
          coverImage: _coverImageController.text,
          featuredImage: _featuredImageController.text,
          bookType: selectedBookType,
        ),*/
   
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Book Posts"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              
      

              // Book Type Dropdown
             

              const SizedBox(height: 20),
              // Title
              buildTextField(_titleController, "Enter title"),
              buildTextField(_authorController, "Enter Author name"),
              buildTextField(_categoryController, "Enter Category"),
              buildTextField(_descriptionController, "Enter Description"),
              buildTextField(_priceController, "Enter Price", isNumber: true),
  const SizedBox(height: 20),

   Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonFormField<String>(
                  value: selectedBookType,
                  items: ['Regular', 'Featured']
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  decoration: InputDecoration(
                    labelText: "Select Book Type",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedBookType = value!;
                    });
                  },
                ),
              ),
               const SizedBox(height: 20), 
              Container(
                width: 450,

                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Column(
                  children: [
                    Icon(Icons.image, size: 100), // Image placeholder
                    const SizedBox(height: 10),
                    Text("Upload the cover image"),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: validateForm,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(500, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color.fromARGB(255, 41, 163, 45),
                  side: const BorderSide(color: Colors.black, width: 2),
                ),
                child: const Text(
                  "Create Book",
                  style: TextStyle(
                      color: Color.fromARGB(255, 225, 222, 222),
                      fontSize: 20.0),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

 
  Widget buildTextField(TextEditingController controller, String hint,
      {bool isNumber = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (value) => value!.isEmpty ? "This field is required" : null,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
