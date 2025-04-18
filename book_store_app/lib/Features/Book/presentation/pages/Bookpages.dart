import 'package:book_store_app/Features/Book/presentation/Bookbloc.dart';
import 'package:book_store_app/Features/Book/presentation/Bookevent.dart';
import 'package:book_store_app/Features/Book/presentation/Bookstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Bookpages extends StatefulWidget {
  const Bookpages({super.key});

  @override
  State<Bookpages> createState() => _BookpagesState();
  
}

class _BookpagesState extends State<Bookpages> {

  @override
void initState() {
  super.initState();
  BlocProvider.of<BookBloc>(context).add(GetAllBooks());
}



  @override
  Widget build(BuildContext context) {
    final bookBloc = BlocProvider.of<BookBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Store'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: BlocBuilder<BookBloc, BookState>(
            builder: (context, state) {
              if (state is BookLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is BookLoaded) {
                return GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: state.books.length,
                  itemBuilder: (context, index) {
                    final book = state.books[index];

                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                          /*  Image.network(
                              book.coverImage,
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                            ),*/
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Book Title
                                  Text(
                                    book.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5),

                                  // Author name
                                  Text(
                                    book.author,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 5),

                                  // Category
                                  Text(
                                    book.category,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  SizedBox(height: 8),

                                  // Rating
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 16,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        book.rating.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),

                                  // Price
                                  Text(
                                    '\$${book.price.toString()}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                  SizedBox(height: 8),

                                  // Featured tag (if applicable)
                                  if (book.featured)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        'Featured',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (state is BookError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
