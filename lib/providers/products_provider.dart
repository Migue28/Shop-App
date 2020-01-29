import 'package:flutter/material.dart';

import './product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
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
    ),
  ];

  List<Product> get items => [..._items];

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void addProduct() {
    //_items.add(value);
    notifyListeners();
  }
}
