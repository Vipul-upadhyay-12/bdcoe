class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
  });

  // Factory constructor to safely parse the JSON response
  factory Product.fromJson(Map json) {
    return Product(
      id: json['id'],
      title: json['title'],
      // Parsed as num and converted to double in case the API returns an integer (e.g., 20 instead of 20.0)
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      image: json['image'],
    );
  }
}