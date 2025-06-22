
import 'package:book_store_app/pages/Homepage.dart';
import 'package:book_store_app/pages/signuppage.dart';
import 'package:flutter/material.dart';

class Landingpage extends StatelessWidget {
  const Landingpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              "SuffleBook.",
              style: TextStyle(
                  fontSize: 40.0,
                  color: const Color.fromARGB(255, 36, 152, 40),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Your Favorite Online Book Strore",
              style: TextStyle(color: Colors.grey, fontSize: 15.0),
            ),
            SizedBox(
              height: 30,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/books.jpg",
                width: 300,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: 300,
              child: Text(
                textAlign: TextAlign.center,
                "Discover Thousands of Books",
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 300,
              child: Text(
                textAlign: TextAlign.center,
                "Explore avast library of e-books across genes-already to read and to enjoy",
                style: TextStyle(color: Colors.grey, fontSize: 14.0),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signuppage()));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(400, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: const Color.fromARGB(255, 41, 163, 45),
                    side: BorderSide(color: Colors.black, width: 2)),
                child: Text(
                  "Get Started",
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
