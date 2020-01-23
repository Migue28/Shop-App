import 'package:flutter/widgets.dart';

import '../models/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get item {
    return [..._items];
  }

  void addProduct() {
    //_items.add(value);
    notifyListeners();
  } 

}