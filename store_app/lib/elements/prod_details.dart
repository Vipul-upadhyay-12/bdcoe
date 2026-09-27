import 'package:flutter/material.dart';
import 'package:store_app/elements/prod_details.dart';
import 'package:store_app/elements/product_model.dart'; // Ensure this path matches your setup

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  
  const ProductDetailsScreen({super.key, required this.product});

  void _addToCart(BuildContext context) {
    // We will wire up the shared_preferences local storage logic here in the next step
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${product.title} added to cart!"),
        backgroundColor: const Color(0xFF0D9488),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color burgundy = const Color(0xFF0D9488);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(product.title, style: const TextStyle(color: Colors.white)),
        backgroundColor: burgundy,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.image,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              product.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              "\$${product.price.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: burgundy),
            ),
            const SizedBox(height: 24),
            const Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: burgundy,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () => _addToCart(context),
          child: const Text("ADD TO CART", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}