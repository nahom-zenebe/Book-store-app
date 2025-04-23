import 'package:book_store_app/Features/Category/presentation/Categoryevent.dart';
import 'package:book_store_app/Features/Category/presentation/Cateogorybloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Createcategorypage extends StatefulWidget {
  const Createcategorypage({super.key});

  @override
  State<Createcategorypage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Createcategorypage> {
  final formkey = GlobalKey<FormState>();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _descritptioncontroller = TextEditingController();

  void handleCategorycreeate() {
    if (formkey.currentState!.validate()) {

      final name = _namecontroller.text;
      final description = _descritptioncontroller.text;

      context.read()<Cateogorybloc>().add(AddCategory(name: name, description: description));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create your Category"),
        centerTitle: true,
      ),
      body: Form(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                controller: _namecontroller,
                decoration: InputDecoration(
                    hintText: "Enter the name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                controller: _descritptioncontroller,
                decoration: InputDecoration(
                    hintText: "Enter the description",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(400, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: const Color.fromARGB(255, 41, 163, 45),
                    side: BorderSide(color: Colors.black, width: 2)),
                child: Text(
                  "Create Category",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 225, 222, 222),
                      fontSize: 20.0),
                ))
          ],
        ),
      ),
    );
  }
}
