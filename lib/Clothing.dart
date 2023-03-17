import 'package:cloud_firestore/cloud_firestore.dart';

class Clothing {
  String id;
  String name;
  String imageUrl;
  String size;
  String price;
  String category;
  String description;
  int quantity; // ajouter la propriété quantité

  Clothing({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.size,
    required this.price,
    required this.category,
    required this.description,
    this.quantity = 1, // initialiser la quantité à 1
  });

  factory Clothing.fromMap(Map<String, dynamic> data, String documentId) {
    return Clothing(
      id: documentId,
      name: data['name'],
      imageUrl: data['imageUrl'],
      size: data['size'],
      price: data['price'],
      category: data['category'],
      description: data['description'],
      quantity: 1, // initialiser la quantité à 1
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'size': size,
      'price': price,
      'category': category,
      'description': description,
      'quantity': quantity, // ajouter la quantité dans la méthode toMap
    };
  }

  factory Clothing.fromSnapshot(QueryDocumentSnapshot snapshot) {
    return Clothing.fromMap(
        snapshot.data() as Map<String, dynamic>, snapshot.id);
  }
}
