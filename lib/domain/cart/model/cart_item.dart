class CartItem {
  final String id;
  final String name;
  final String image;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  // Serialization for Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }

  // Deserialization from Firebase
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] ?? 'id',
      name: map['name'] ?? 'noName',
      image: map['imageUrl'] ?? 'image',
      price: map['price'] ?? 99999,
      quantity: map['quantity'] ?? 999999,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }
}
