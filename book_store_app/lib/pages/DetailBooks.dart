import 'package:book_store_app/Features/Book/domian/Bookentities.dart';
import 'package:flutter/material.dart';

class Detailbooks extends StatefulWidget {
  final Bookentities books;
  const Detailbooks({super.key, required this.books});

  @override
  State<Detailbooks> createState() => _DetailbooksState();
}

class _DetailbooksState extends State<Detailbooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
               
                Padding(

                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Image.asset(
                      "assets/books.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

               
                Positioned(
                  top: 40,
                  left: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      backgroundColor: Colors.black54,
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                                    icon: Icon(
                                      widget.books.featured
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: widget.books.featured
                                          ? Colors.red
                                          : Colors.white,
                                      size: 28,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        widget.books.featured = !widget.books.featured;
                                      });
                                    },
                                  ),
                  ),
                ),
              ],
            ),

      
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.books.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.person),
                      Text(
                    "Author: ${widget.books.author}",
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.books.description ?? "No description available.",
                    style: TextStyle(fontSize: 16),
                  ),

                   Text(
                    widget.books.description ?? "No description available.",
                    style: TextStyle(fontSize: 16),
                  ),
                 


                  Text(
                    widget.books.price.toString() ?? "No price available.",
                    style: TextStyle(fontSize: 16),
                  ),
                   Text(
                    widget.books.category ?? "No cateogry available.",
                    style: TextStyle(fontSize: 16),
                  ),
                 
                 
                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
