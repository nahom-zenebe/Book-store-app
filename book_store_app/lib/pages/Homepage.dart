import 'package:book_store_app/Features/Book/presentation/Bookbloc.dart';
import 'package:book_store_app/Features/Book/presentation/Bookevent.dart';
import 'package:book_store_app/Features/Book/presentation/pages/Bookpages.dart';
import 'package:book_store_app/Features/Category/presentation/DisplayCategorypage.dart';
import 'package:book_store_app/pages/Cartpage.dart';
import 'package:book_store_app/pages/CreateBook.dart';
import 'package:book_store_app/widgets/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Store'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text("Semera Ababa"),
                accountEmail: Text("Semeraababa@gmail.com")),
            SizedBox(height: 40),
            ListTile(
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Homepage()));
              },
              title: Text("Home"),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.add),
              onTap: () {
                 Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Createbook()));
              },
              title: Text("Create Book"),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.shopping_cart_outlined),
              onTap: () {
                 Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>Cartpage()));
              },
              title: Text("Cart"),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.save),
              onTap: () {}, 
              title: Text("Saved"),
            ),
            SizedBox(height: 80),
            Divider(height: 2, color: Colors.black),
            ListTile(
              leading: Icon(Icons.save),
              onTap: () {},
              title: Text("Saved"),
            )
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
            SizedBox(height: 20),
            // Fixed height container for categories
            SizedBox(
              height: 100, // Fixed height for categories
              child: Displaycategorypage(),
            ),
            SizedBox(height: 20),
            // Expanded takes remaining space for books
            Expanded(
              child: Bookpages(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Bottomnavbar(),
    );
  }
}