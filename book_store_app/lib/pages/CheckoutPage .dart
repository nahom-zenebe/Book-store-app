import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _cardController = CardEditController();
  bool _isProcessing = false;

  final Map<String, dynamic> book = {
    'title': 'Flutter App Development Cookbook',
    'author': 'Albert Einstein',
    'price': 24.99,
    'image': 'https://m.media-amazon.com/images/I/71H-WBRVDrL._AC_UF1000,1000_QL80_.jpg',
    'description': 'A comprehensive guide to building cross-platform apps with Flutter.',
  };

  @override
  void initState() {
    super.initState();
    _cardController.addListener(update);
  }

  @override
  void dispose() {
    _cardController.removeListener(update);
    _cardController.dispose();
    super.dispose();
  }

  void update() => setState(() {});

  Future<void> _handlePayment() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isProcessing = true);

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Payment Successful'),
          content: const Text('Your order has been placed successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double total = (book['price'] as double) + 2.5;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBookSummary(),
            const SizedBox(height: 24),

            const Text(
              'Payment Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  CardFormField(
                    style: CardFormStyle(
                      backgroundColor: Colors.white,
                      borderColor: Colors.grey.shade300,
                      borderRadius: 8,
                      borderWidth: 1,
                      textColor: Colors.black,
                      fontSize: 16,
                      placeholderColor: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Billing Address',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter your billing address' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter your city' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ZIP Code',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter your ZIP code' : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            _buildOrderSummary(),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _handlePayment,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isProcessing
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Pay \$${total.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookSummary() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            book['image'] ?? '',
            width: 80,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book['title'] ?? '',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'by ${book['author']}',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 8),
              Text(
                book['description'] ?? '',
                style: const TextStyle(fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummary() {
    final double subtotal = book['price'] ?? 0.0;
    const double tax = 2.50;
    final double total = subtotal + tax;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Order Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const Text('Subtotal'), Text('\$${subtotal.toStringAsFixed(2)}')],
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Shipping'), Text('Free')],
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Tax'), Text('\$2.50')],
        ),
        const Divider(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('\$${total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
