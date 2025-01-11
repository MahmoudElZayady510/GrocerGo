class CartItem {
  final String id;
  final String name;
  final String image;
  final String category;
  final String description;
  final String unit;
  final double price;
  final int quantity;

  CartItem( {
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.description,
    required this.category,
    required this.unit,
  });

  // Serialization for Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
      'description': description,
      'category': category,
      'unit': unit
    };
  }

  // Deserialization from Firebase
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] ?? 'id',
      name: map['name'] ?? 'noName',
      image: map['image'] ?? 'image',
      price: map['price'] ?? 99999,
      quantity: map['quantity'] ?? 999999,
      description: map['description'] ?? 'nodesc',
      category: map['category'] ?? 'noCat',
      unit: map['unit'] ?? 'Unit'
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
      'description': description
    };
  }
}
