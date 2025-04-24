import 'package:book_store_app/Features/Book/presentation/Bookbloc.dart';
import 'package:book_store_app/Features/Book/presentation/Bookevent.dart';
import 'package:book_store_app/Features/Book/presentation/Bookstate.dart';
import 'package:book_store_app/Features/Book/presentation/Cartbloc.dart';
import 'package:book_store_app/Features/Book/presentation/Cartevent.dart';
import 'package:book_store_app/pages/DetailBooks.dart';
import 'package:book_store_app/widgets/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

    return BlocBuilder<BookBloc, BookState>(
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
              childAspectRatio: 0.65,
            ),
            itemCount: state.books.length,
            itemBuilder: (context, index) {
              final book = state.books[index];

              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            "assets/books.jpg",
                            width: double.infinity,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: Icon(
                                book.featured
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: book.featured ? Colors.red : Colors.white,
                                size: 28,
                              ),
                              onPressed: () {
                                setState(() {
                                  book.featured = !book.featured;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                book.author,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 6),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green[700],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  book.category,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.orange, size: 16),
                                      SizedBox(width: 4),
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
                                    '\$${book.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[800],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.read<Cartbloc>().add(Addtocart(books: book));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green[800],
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text("Add", style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (_) => Detailbooks(books: book),
                                      ));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueGrey[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text("View", style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
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
    );
  }
}
