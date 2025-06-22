import 'package:book_store_app/Features/Book/presentation/Cartbloc.dart';
import 'package:book_store_app/Features/Book/presentation/Cartevent.dart';
import 'package:book_store_app/Features/Book/presentation/Cartstate.dart';
import 'package:book_store_app/pages/CheckoutPage%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  // Local state for quantity management (frontend only)
  final Map<String, int> _itemQuantities = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Shopping Cart",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: BlocBuilder<Cartbloc, Cartstate>(
        builder: (context, state) {
          // Initialize quantities if not already set
          for (var book in state.Books) {
            _itemQuantities.putIfAbsent(book.id, () => 1);
          }

          return state.Books.isEmpty
              ? _buildEmptyCart()
              : _buildCartWithItems(state);
        },
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined,
              size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 20),
          Text("Your cart is empty",
              style: TextStyle(fontSize: 20, color: Colors.grey.shade600)),
          const SizedBox(height: 10),
          Text("Browse our collection to add items",
              style: TextStyle(color: Colors.grey.shade500)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Continue Shopping",
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildCartWithItems(Cartstate state) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            itemCount: state.Books.length,
            itemBuilder: (context, index) {
              final book = state.Books[index];
              final quantity = _itemQuantities[book.id] ?? 1;

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              "assets/books.jpg",
                              width: 80,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  book.description,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "\$${(book.price * quantity).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade800,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1, color: Colors.grey.shade300),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Quantity controls
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove, size: 18),
                                  onPressed: () {
                                    if (quantity > 1) {
                                      setState(() {
                                        _itemQuantities[book.id] = quantity - 1;
                                      });
                                    }
                                  },
                                  padding: const EdgeInsets.all(4),
                                  constraints: const BoxConstraints(),
                                  color: quantity > 1
                                      ? Colors.blue.shade600
                                      : Colors.grey,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    quantity.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add, size: 18),
                                  onPressed: () {
                                    setState(() {
                                      _itemQuantities[book.id] = quantity + 1;
                                    });
                                  },
                                  padding: const EdgeInsets.all(4),
                                  constraints: const BoxConstraints(),
                                  color: Colors.blue.shade600,
                                ),
                              ],
                            ),
                          ),
                          // Remove button
                          TextButton.icon(
                            onPressed: () {
                              context
                                  .read<Cartbloc>()
                                  .add(Removefromcart(books: book));
                              Fluttertoast.showToast(
                                msg: "${book.title} removed from cart",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red.shade400,
                                textColor: Colors.white,
                              );
                            },
                            icon: Icon(Icons.delete_outline,
                                color: Colors.red.shade600),
                            label: Text(
                              "Remove",
                              style: TextStyle(color: Colors.red.shade600),
                            ),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Colors.red.shade50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        _buildCheckoutSection(state),
      ],
    );
  }

  Widget _buildCheckoutSection(Cartstate state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Subtotal", style: TextStyle(fontSize: 16)),
              Text(
                "\$${_calculateSubtotal(state).toStringAsFixed(2)}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Shipping", style: TextStyle(fontSize: 16)),
              Text(
                "\$${_calculateShipping(state).toStringAsFixed(2)}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(height: 30, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$${_calculateTotal(state).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CheckoutPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
              ),
              child: const Text(
                "PROCEED TO CHECKOUT",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateSubtotal(Cartstate state) {
    double subtotal = 0;
    for (var book in state.Books) {
      subtotal += book.price * (_itemQuantities[book.id] ?? 1);
    }
    return subtotal;
  }

  double _calculateShipping(Cartstate state) {
    return _calculateSubtotal(state) > 50 ? 0 : 5.99;
  }

  double _calculateTotal(Cartstate state) {
    return _calculateSubtotal(state) + _calculateShipping(state);
  }

  void _showCheckoutDialog(BuildContext context, Cartstate state) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Order Summary",
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var book in state.Books)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${_itemQuantities[book.id]} × ${book.title}",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    Text(
                      "\$${(book.price * (_itemQuantities[book.id] ?? 1)).toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Subtotal:"),
                Text("\$${_calculateSubtotal(state).toStringAsFixed(2)}"),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Shipping:"),
                Text("\$${_calculateShipping(state).toStringAsFixed(2)}"),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  "\$${_calculateTotal(state).toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Fluttertoast.showToast(
                msg: "Order placed successfully!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.green,
                textColor: Colors.white,
              );
              context.read<Cartbloc>().add(ClearCart());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text("Confirm Order"),
          ),
        ],
      ),
    );
  }
}
