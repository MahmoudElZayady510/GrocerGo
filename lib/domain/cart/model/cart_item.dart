class CartItem {
  final String id;
  final String name;
  final String image;
  final String category;
  final String description;
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
      'category': category
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
      category: map['category'] ?? 'noCat'
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
