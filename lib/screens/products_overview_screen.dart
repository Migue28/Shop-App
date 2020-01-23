import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/product_item.dart';

class ProductsOverviewScreeen extends StatelessWidget {
  final List<Product> loadedProducts = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Lolis Shop'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: loadedProducts.length,
        itemBuilder: (ctx, i) => ProductItem(
          id: loadedProducts[i].id,
          title: loadedProducts[i].title,
          imageUrl: loadedProducts[i].imageUrl,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
