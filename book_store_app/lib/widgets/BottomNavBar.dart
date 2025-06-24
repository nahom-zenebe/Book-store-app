import 'package:book_store_app/pages/CreateBook.dart';
import 'package:book_store_app/pages/Profilepage.dart';
import 'package:flutter/material.dart';
import 'package:book_store_app/Features/Category/presentation/DisplayCategorypage.dart';
import 'package:book_store_app/pages/Cartpage.dart';
import 'package:book_store_app/pages/CreateCategorypage.dart';
import 'package:book_store_app/pages/Homepage.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Homepage(),
    Cartpage(),
     CreateBook(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Createcategorypage()),
          );
        },
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.white,
        elevation: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              color: _selectedIndex == 0
                  ? const Color.fromARGB(255, 52, 195, 23)
                  : Colors.grey,
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: Icon(Icons.category),
              color: _selectedIndex == 1
                  ? const Color.fromARGB(255, 52, 195, 23)
                  : Colors.grey,
              onPressed: () => _onItemTapped(1),
            ),
            SizedBox(width: 40), // space for FAB
            IconButton(
              icon: Icon(Icons.shopping_cart),
              color: _selectedIndex == 2
                  ? const Color.fromARGB(255, 52, 195, 23)
                  : Colors.grey,
              onPressed: () => _onItemTapped(2),
            ),
            IconButton(
              icon: Icon(Icons.person),
              color: _selectedIndex == 3
                  ? const Color.fromARGB(255, 52, 195, 23)
                  : Colors.grey,
              onPressed: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}
