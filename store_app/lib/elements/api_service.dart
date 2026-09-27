import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store_app/elements/product_model.dart';

class ApiService {
  // The API endpoint provided in your PDF
  static const String url = 'https://fakestoreapi.com/products';

  Future getProducts() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Decode the JSON string into a List of dynamic objects
        List data = jsonDecode(response.body);
        
        // Map each object into our standard Dart Product class
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load products");
      }
    } catch(e){
      print("API Error: $e");
      return [];
    }
  }
}