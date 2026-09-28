import 'package:flutter/material.dart';
import 'package:store_app/cart_services.dart';
import 'cart_services.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State createState() => _CartScreenState();
}

class _CartScreenState extends State {
  final CartService _cartService = CartService();
  List cartItems = [];
  bool _isLoading = true;
  final Color burgundy = const Color(0xFF800020);

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  void _loadCart() async {
    final items = await _cartService.getCart();
    setState(() {
      cartItems = items;
      _isLoading = false;
    });
  }

  double get _totalPrice {
    return cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Your Cart", style: TextStyle(color: Colors.white)),
        backgroundColor: burgundy,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading 
        ? Center(child: CircularProgressIndicator(color: burgundy))
        : cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty", style: TextStyle(fontSize: 18)))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        title: Text(item['title'], maxLines: 1, overflow: TextOverflow.ellipsis),
                        subtitle: Text("Quantity: ${item['quantity']}"),
                        trailing: Text("\$${(item['price'] * item['quantity']).toStringAsFixed(2)}", 
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: const Border(top: BorderSide(color: Colors.grey)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text("\$${_totalPrice.toStringAsFixed(2)}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: burgundy)),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}