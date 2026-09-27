import 'package:flutter/material.dart';
import 'package:store_app/elements/prod_details.dart';
import 'api_service.dart';
import 'package:store_app/elements/product_model.dart';
import 'package:store_app/credentials/auth_service.dart';
// import 'product_details_screen.dart'; // We will build this next

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  final ApiService _apiService = ApiService();
  late Future _productsFuture;
  final Color burgundy = const Color(0xFF800020);

  @override
  void initState() {
    super.initState();
    // Initialize the future once to prevent unnecessary API calls on rebuild
    _productsFuture = _apiService.getProducts();
  }

  void _logout() async {
    try {
      //await CartService().clearCart();
      await AuthService().logout();
    } catch (e) {
      print("Logout Error: $e"); // This will print directly to your Chrome console
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Slight off-white background to make cards pop
      appBar: AppBar(
        title: const Text("Store", style: TextStyle(color: Colors.white)),
        backgroundColor: burgundy,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
          )
        ],
      ),
      body: FutureBuilder(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: burgundy));
          } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Failed to load products."));
          }

          final products = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items per row
              childAspectRatio: 0.7, // Taller cards to fit images and text
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return _buildProductCard(product);
            },
          );
        },
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product)));
      },
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                "\$${product.price.toStringAsFixed(2)}",
                style: TextStyle(color: burgundy, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}