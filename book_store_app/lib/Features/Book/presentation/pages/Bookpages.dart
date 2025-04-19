import 'package:book_store_app/Features/Book/presentation/Bookbloc.dart';
import 'package:book_store_app/Features/Book/presentation/Bookevent.dart';
import 'package:book_store_app/Features/Book/presentation/Bookstate.dart';
import 'package:book_store_app/widgets/BottomNavBar.dart';
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

    return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
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
                      childAspectRatio: 0.65),
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
                            Stack(
                              children: [
                                Image.asset(
                                  "assets/books.jpg",
                                  width: double.infinity,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: IconButton(
                                    icon: Icon(
                                      book.featured
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: book.featured
                                          ? Colors.red
                                          : Colors.white,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      // Assuming you want to toggle the "featured" status
                                      setState(() {
                                        book.featured= !book.featured;
                                      });

                                      // You might want to send an API request to update the backend
                                      // Example: bookBloc.add(UpdateBookFeaturedStatus(book));
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Padding(
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
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 114, 197, 19),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        book.category,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),

                                    // Rating and Price
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
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
                                        Text(
                                          '\$${book.price.toString()}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                ),
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
        )
        );
    
  }
}
