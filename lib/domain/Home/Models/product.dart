class Grocery {
  final String id;
  final String name;
  final double price;
  final String image;
  final String category;
  final String description;
  final String unit;

  Grocery({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.category,
    required this.unit,
  });

  factory Grocery.fromMap(Map<String, dynamic> map) {
    return Grocery(
      id: map['id'] ?? 'id',
      name: map['name'] ?? 'noName',
      price: map['price'] ?? 999999,
      image: map['image'] ?? 'image',
      description: map['description'] ?? 'des',
      category: map['category'] ?? 'noCat',
      unit: map['unit'] ?? 'Unit'
    );
  }
}
