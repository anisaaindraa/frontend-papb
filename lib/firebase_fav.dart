import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritesModel extends ChangeNotifier {
  Set<String> _favorites = {};

  Set<String> get favorites => _favorites;

  FavoritesModel() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists) {
        _favorites = Set<String>.from(doc['favorites'] ?? []);
        notifyListeners();
      }
    }
  }

  Future<void> addFavorite(String word) async {
    _favorites.add(word);
    await _updateFavorites();
    notifyListeners();
  }

  Future<void> removeFavorite(String word) async {
    _favorites.remove(word);
    await _updateFavorites();
    notifyListeners();
  }

  Future<void> _updateFavorites() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'favorites': _favorites.toList(),
      }, SetOptions(merge: true));
    }
  }
}
