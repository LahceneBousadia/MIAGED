import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Clothing.dart';

class ClothingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Clothing>> getClothingStream({String? category}) {
    Query query = _firestore.collection('clothing');

    if (category != null && category != 'Tous') {
      query = query.where('category', isEqualTo: category);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final clothing = Clothing.fromMap(data, doc.id);
        return clothing;
      }).toList();
    });
  }
}
