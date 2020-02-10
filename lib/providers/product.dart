// import 'dart:convert';

import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;

// import '../models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus() async {
    isFavorite = !isFavorite;

    notifyListeners();
    /* final url =
        'https://flutter-shop-app-4bd8d.firebaseio.com/products/$id.json';

    try {
      await http.patch(url, body: {
        json.encode({
          'isFavorite': isFavorite,
        }),
      });
      print('try');
      notifyListeners();
    } catch (error) {
      isFavorite = !isFavorite;
      print('catch');
      notifyListeners();
      throw HttpException(error);
    } */
  }
}
