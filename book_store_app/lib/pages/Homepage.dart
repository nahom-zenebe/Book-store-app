import 'dart:async';
import 'package:book_store_app/Features/Book/domian/Bookentities.dart';
import 'package:book_store_app/Features/Book/presentation/Cartbloc.dart';
import 'package:book_store_app/Features/Book/presentation/Cartevent.dart';
import 'package:book_store_app/pages/AdminDashboard.dart';
import 'package:book_store_app/pages/Profilepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_store_app/Features/Book/presentation/Bookbloc.dart';
import 'package:book_store_app/Features/Book/presentation/Bookevent.dart';
import 'package:book_store_app/Features/Book/presentation/Bookstate.dart';
import 'package:book_store_app/Features/Category/presentation/DisplayCategorypage.dart';
import 'package:book_store_app/pages/Cartpage.dart';
import 'package:book_store_app/pages/CreateBook.dart';
import 'package:book_store_app/pages/DetailBooks.dart';
import 'package:book_store_app/widgets/BottomNavBar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<Bookentities> allBook = [];
  List<Bookentities> filteredBook = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BookBloc>(context).add(GetAllBooks());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void handleSearch(String query) {
    setState(() {
      filteredBook = allBook.where((book) =>
          book.title.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Store'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Semera Ababa"),
              accountEmail: Text("Semeraababa@gmail.com"),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Homepage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Create Book"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Createbook()));
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart_outlined),
              title: Text("Cart"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Cartpage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart_outlined),
              title: Text("Admin"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => Admindashboard()));
              },
            ),
            ListTile(
              leading: Icon(Icons.save),
              title: Text("Saved"),
              onTap: () {},
            ),
            SizedBox(height: 90),
            Divider(height: 2, color: Colors.black),
            SizedBox(height: 5),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                onChanged: handleSearch,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            SizedBox(height: 100, child: Displaycategorypage()),
            Expanded(
              child: BlocBuilder<BookBloc, BookState>(
                builder: (context, state) {
                  if (state is BookLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is BookLoaded) {
                    if (allBook.isEmpty) {
                      allBook = state.books;
                      filteredBook = state.books;
                    }
                    return GridView.builder(
                      padding: EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: filteredBook.length,
                      itemBuilder: (context, index) {
                        final book = filteredBook[index];
                        return Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          shadowColor: Colors.grey.shade400,
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
                                          color: book.featured
                                              ? Colors.red
                                              : Colors.white,
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
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          book.title,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          book.author,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 6),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.teal[600],
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.star,
                                                    color: Colors.amber[700],
                                                    size: 16),
                                                SizedBox(width: 4),
                                                Text(
                                                  book.rating.toString(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.amber[700],
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
                                                  context.read<Cartbloc>().add(
                                                      Addtocart(books: book));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.teal,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  elevation: 2,
                                                ),
                                                child: Text("Add",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        Detailbooks(books: book),
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.indigo[700],
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                elevation: 2,
                                              ),
                                              child: Text("View",
                                                  style: TextStyle(
                                                      color: Colors.white)),
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
              ),
            ),
          ],
        ),
      ),
     
    );
  }
}
