import 'package:book_store_app/Features/Book/presentation/pages/Bookpages.dart';
import 'package:book_store_app/pages/Cartpage.dart';
import 'package:book_store_app/pages/CreateBook.dart';
import 'package:flutter/material.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Bookpages(),
    Center(child: Text("Search")),
    Cartpage(),
    Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Createbook()));
        },
        backgroundColor: const Color.fromARGB(255, 56, 189, 29),
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              color: _selectedIndex == 0
                  ? const Color.fromARGB(255, 52, 195, 23)
                  : Colors.grey,
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              color: _selectedIndex == 1
                  ? const Color.fromARGB(255, 52, 195, 23)
                  : Colors.grey,
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),
            SizedBox(width: 40),
            IconButton(
              icon: Icon(Icons.shopping_cart_rounded),
              color: _selectedIndex == 2
                  ? const Color.fromARGB(255, 52, 195, 23)
                  : Colors.grey,
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              color: _selectedIndex == 3
                  ? const Color.fromARGB(255, 52, 195, 23)
                  : Colors.grey,
              onPressed: () {
                setState(() {
                  _selectedIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
