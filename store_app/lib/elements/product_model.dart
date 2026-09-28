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

  // Factory constructor is usedd to safely parse the json response
  factory Product.fromJson(Map json) {
    return Product(
      id: json['id'],
      title: json['title'],
      // Parsed as num and converted to double in case the api returns an integer
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      image: json['image'],
    );
  }
}