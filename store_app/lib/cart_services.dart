import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/elements/product_model.dart';

class CartService {
  static const String _cartKey = 'local_cart';

  // Adds a product or increases its quantity
  Future addToCart(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    List savedCart = prefs.getStringList(_cartKey) ?? [];
    
    List cartItems = savedCart.map((item) => jsonDecode(item) as Map).toList();
    
    bool exists = false;
    for (var item in cartItems) {
      if (item['id'] == product.id) {
        item['quantity'] = (item['quantity'] ?? 1) + 1;
        exists = true;
        break;
      }
    }
    
    if (!exists) {
      cartItems.add({
        'id': product.id,
        'title': product.title,
        'price': product.price,
        'quantity': 1,
      });
    }
    
    await prefs.setStringList(_cartKey, cartItems.map((item) => jsonEncode(item)).toList());
  }

  // Retrieves the cart to display on the screen
  Future getCart() async {
    final prefs = await SharedPreferences.getInstance();
    List savedCart = prefs.getStringList(_cartKey) ?? [];
    return savedCart.map((item) => jsonDecode(item) as Map).toList();
  }

  // Wipes the cart from device memory on logout
  Future clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}