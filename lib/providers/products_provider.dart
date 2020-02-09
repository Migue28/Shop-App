import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    /* Product(
      id: 'p1',
      title: 'Tsukiko Tsutsukakushi',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'http://pm1.narvii.com/6682/1bdc8c9da88349d05bff552c2357181fdd17db21_00.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Okita Souji',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://c4.wallpaperflare.com/wallpaper/829/114/563/fate-series-fate-grand-order-okita-souji-wallpaper-preview.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Eucliwood Hellscythe',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://i.pinimg.com/236x/5e/6b/89/5e6b89682d45f4e6ebf550bf8b738623--anime-fantasy-cosplay-ideas.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Shiro',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://vignette.wikia.nocookie.net/no-game-no-life/images/0/09/Shiro.png/revision/latest?cb=20170323163115',
    ), */
  ];

  List<Product> get items => [..._items];

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetsProducts() async {
    const url = 'https://flutter-shop-app-4bd8d.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];

      extractedData.forEach((prodId, prodData) {
            loadedProducts.add(Product(
              id: prodId,
              title: prodData['title'],
              description: prodData['description'],
              price: prodData['price'],
              imageUrl: prodData['imageUrl'],
              isFavorite: prodData['isFavorite'],
            ));
          });
      _items = loadedProducts;

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://flutter-shop-app-4bd8d.firebaseio.com/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );

      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );

      _items.add(newProduct);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;

      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);

    notifyListeners();
  }
}
