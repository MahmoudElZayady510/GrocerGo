import 'package:cloud_firestore/cloud_firestore.dart';

class addProducts {
  final firestore = FirebaseFirestore.instance;

  final List<Map<String, dynamic>> products = [
    {
      "name": "Strawberry",
      "lowercasename": "strawberry",
      "category": "Fruits",
      "description": "Fresh and juicy strawberries.",
      "image": "https://images.unsplash.com/photo-1495570689269-d883b1224443?q=80&w=1931&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "price": 3.49
    },
    {
      "name": "Pineapple",
      "lowercasename": "pineapple",
      "category": "Fruits",
      "description": "Sweet and tangy pineapples.",
      "image": "https://media.istockphoto.com/id/513241940/photo/pineapple-on-the-wood-texture-background.jpg?s=2048x2048&w=is&k=20&c=1Te4RooAGWjLYPQ1mA6QzXP_wW9Zgc9gd1gAlLaV7MI=",
      "price": 4.99
    },
    {
      "name": "Lettuce",
      "lowercasename": "lettuce",
      "category": "Vegetables",
      "description": "Crisp and fresh lettuce for salads.",
      "image": "https://plus.unsplash.com/premium_photo-1678198891468-17f08ad39c29?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "price": 1.49
    },
    {
      "name": "Potato",
      "lowercasename": "potato",
      "category": "Vegetables",
      "description": "Starchy potatoes perfect for mashing or frying.",
      "image": "https://media.istockphoto.com/id/1408413704/photo/natural-potatoes-on-the-farmers-market-stall.jpg?s=2048x2048&w=is&k=20&c=UKSojm2EnbnF2-P4FLoYQm8DhAX9Z26GTyu6hpqUNmo=",
      "price": 2.99
    },
    {
      "name": "Beef Steak",
      "lowercasename": "beef steak",
      "category": "Meat",
      "description": "Juicy, tender beef steaks.",
      "image": "https://media.istockphoto.com/id/1580779694/photo/the-king-of-steaks-the-tomahawk.jpg?s=2048x2048&w=is&k=20&c=JyKWnnluhBUOhAHTuy7sWPVF8ROU4RW4u9fWTncTg94=",
      "price": 12.99
    },
    {
      "name": "Tilapia Fillet",
      "lowercasename": "tilapia fillet",
      "category": "Fish",
      "description": "Fresh tilapia fillets, great for baking or grilling.",
      "image": "https://media.istockphoto.com/id/95828955/photo/raw-pink-filleted-tilapia-fish.jpg?s=2048x2048&w=is&k=20&c=Fo-2vE2oidOVL8ywWhv_edDc80fmXFHngfRvtnqQcd8=",
      "price": 6.99
    },
    {
      "name": "Shrimp",
      "lowercasename": "shrimp",
      "category": "Fish",
      "description": "Delicious and fresh shrimp, perfect for seafood dishes.",
      "image": "https://images.unsplash.com/photo-1674066625481-8cffd7cf5aac?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "price": 14.99
    },
    {
      "name": "Greek Yogurt",
      "lowercasename": "greek yogurt",
      "category": "Dairy",
      "description": "Rich and creamy Greek yogurt, high in protein.",
      "image": "https://media.istockphoto.com/id/927134424/photo/plain-yogurt-is-super-healthy.jpg?s=2048x2048&w=is&k=20&c=-VgQ_hOr-Zq99Q53g_sGEWjaREVFYKglC3hZYdvNs00=",
      "price": 2.99
    },
    {
      "name": "Butter",
      "lowercasename": "butter",
      "category": "Dairy",
      "description": "Creamy butter, perfect for cooking and baking.",
      "image": "https://plus.unsplash.com/premium_photo-1700612685744-a8447b4cd884?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "price": 3.49
    },
    {
      "name": "Iced Tea",
      "lowercasename": "iced tea",
      "category": "Beverages",
      "description": "Refreshing iced tea with a hint of lemon.",
      "image": "https://media.istockphoto.com/id/530186732/photo/fresh-homemade-peach-sweet-tea.jpg?s=2048x2048&w=is&k=20&c=ynqsa625x5UQnM8ITzTOa6wMyhlAHh-bP5XcIh33RyU=",
      "price": 1.99
    },
    {
      "name": "Sparkling Water",
      "lowercasename": "sparkling water",
      "category": "Beverages",
      "description": "Refreshing sparkling water with a touch of flavor.",
      "image": "https://media.istockphoto.com/id/451992561/photo/pouring-mineral-water-in-the-glass.jpg?s=2048x2048&w=is&k=20&c=FB6TtPaX2BbfPgTYo2E7n6dREJkCNvI1pYAoXjkF0W4=",
      "price": 2.49
    },
    {
      "name": "Croissant",
      "lowercasename": "croissant",
      "category": "Bakery",
      "description": "Buttery and flaky croissants, baked fresh daily.",
      "image": "https://plus.unsplash.com/premium_photo-1661743823829-326b78143b30?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "price": 1.99
    },
    {
      "name": "Bagels",
      "lowercasename": "bagels",
      "category": "Bakery",
      "description": "Freshly baked bagels, perfect for breakfast.",
      "image": "https://media.istockphoto.com/id/182790291/photo/two-sesame-seed-bagels-isolated-on-white-background.jpg?s=2048x2048&w=is&k=20&c=1bIdzjOD3JL9hEoYzZ5nnbhQE2Jdm1MDqt6qCaWdplQ=",
      "price": 3.99
    }
  ]
  ;



  Future<void> addProductsToFirestore() async { // Returns Future<void>
    // ... (Firebase initialization)

    try {
      for (final product in products) {
        await firestore.collection('groceries').add(product);
        print('Added product: ${product['name']}');
      }
      print('Finished adding products.');
    } catch (e) {
      print('Error adding products: $e');
    }
  }
}