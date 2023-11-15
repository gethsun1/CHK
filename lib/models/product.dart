class Product {
  int id;
  String name;
  double quantity; // Added field for product quantity
  double pricePerKG;
  String image;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.pricePerKG,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price_per_kg': pricePerKG,
      'image': image,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      pricePerKG: map['price_per_kg'],
      image: map['image'],
    );
  }
}
