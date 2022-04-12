import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavourite = false,
  });

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    bool? isFavourite,
  }) =>
      Product(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
        isFavourite: isFavourite ?? this.isFavourite,
      );

  void _setFavouriteValue(bool newValue) {
    isFavourite = newValue;
  }

  Future<void> toggleFavourite() async {
    final String url =
        'https://shop-app-e7566-default-rtdb.firebaseio.com/products/$id.json';
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();

    try {
      final response = await http.patch(
        Uri.parse(url),
        body: json.encode({
          'isFavourite': isFavourite,
        }),
      );
      if (response.statusCode >= 400) {
        _setFavouriteValue(oldStatus);
        notifyListeners();
      }
    } catch (error) {
      _setFavouriteValue(oldStatus);
      notifyListeners();
    }
  }
}
