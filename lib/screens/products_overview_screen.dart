import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

class ProductsOverviewScreeen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Lolis Shop'),
      ),
      body: ProductsGrid(),
    );
  }
}
