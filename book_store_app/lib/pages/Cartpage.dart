import 'package:book_store_app/Features/Book/presentation/Cartbloc.dart';
import 'package:book_store_app/Features/Book/presentation/Cartevent.dart';
import 'package:book_store_app/Features/Book/presentation/Cartstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book cart"),
        centerTitle: true,
      ),
      
      body: BlocBuilder<Cartbloc, Cartstate>(builder: (context, state) {
        return Column(

          children: [
                     SizedBox(height: 30,),
            ...state.Books.map((books) => ListTile(
                  leading: Image.asset("assets/books.jpg"),
                  title: Text(books.title),
                  subtitle: Text(books.description),
                  trailing:ElevatedButton(
                onPressed: () {
                  context.read<Cartbloc>().add(Removefromcart(books: books));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(120, 50),
                  backgroundColor: Colors.red[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Remove",
                  style: TextStyle(color: Colors.white),
                )),
                )),
            SizedBox(height: 10,),
            Divider(height: 3,),
             SizedBox(height: 10,),
            Text('Total: \$${state.totalPrice.toStringAsFixed(2)}'),
              SizedBox(height: 40,),

              ElevatedButton(
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(400, 50),
                  backgroundColor: const Color.fromARGB(255, 8, 172, 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Checkout",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        );
      }),
    );
  }
}
