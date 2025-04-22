import 'package:flutter/material.dart';

class Createbook extends StatefulWidget {
  const Createbook({super.key});

  @override
  State<Createbook> createState() => _CreatebookState();
}

class _CreatebookState extends State<Createbook> {
  TextEditingController _titlecontroller = TextEditingController();
    TextEditingController _authorcontroller = TextEditingController();
     TextEditingController _Categorycontroller = TextEditingController();
      TextEditingController _descriptioncontroller = TextEditingController();
    TextEditingController _pricecontroller = TextEditingController();
      TextEditingController _coverimagecontroller = TextEditingController();
      TextEditingController _Featuredimagecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Book Posts"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                          bottom: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                              style: BorderStyle.solid),
                          left: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                          right: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                              style: BorderStyle.solid))),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/image.svg",
                        width: 200,
                        height: 200,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Upload the cover image")
                    ],
                  )),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Enter title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Enter Author name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
             
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Enter Category",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Enter description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Enter price",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(500, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color.fromARGB(255, 41, 163, 45),
                      side: BorderSide(color: Colors.black, width: 2)),
                  child: Text(
                    "Create Book",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 225, 222, 222),
                        fontSize: 20.0),
                  ))
            ],
          ),
        ));
  }
}
