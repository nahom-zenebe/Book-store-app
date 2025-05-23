import 'package:book_store_app/Features/Book/presentation/Cartbloc.dart';
import 'package:book_store_app/Features/Book/presentation/Cartevent.dart';
import 'package:book_store_app/Features/Book/presentation/Cartstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


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
        return state.Books.length==0 ? Center(child: Text("No Book In the Cart"),)  : SingleChildScrollView(
          child: Column(
          
            children: [
           
              
                       SizedBox(height: 30,),
              ...state.Books.map((books) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  child: Card(
    color: const Color.fromARGB(255, 229, 230, 231),
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: ListTile(
      contentPadding: EdgeInsets.all(12),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset("assets/books.jpg", width: 50, height: 50, fit: BoxFit.cover),
      ),
      title: Text(books.title),
      subtitle: Text(books.description),
      trailing: ElevatedButton(
        onPressed: () {
          context.read<Cartbloc>().add(Removefromcart(books: books));

          Fluttertoast.showToast(
            msg: "${books.title} successfully removed from Cart",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromARGB(255, 92, 214, 17),
            textColor: Colors.white,
            fontSize: 16.0,
          );
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(100, 40),
          backgroundColor: Colors.red[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text("Remove", style: TextStyle(color: Colors.white)),
      ),
    ),
  ),
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
          ),
        );
      }),
    );
  }
}
