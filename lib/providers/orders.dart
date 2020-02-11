import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    print('orders class add');
    const url = 'https://flutter-shop-app-4bd8d.firebaseio.com/orders.json';

    try {
      final dateTime = DateTime.now();
      final response = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'dateTime': dateTime.toString(),
          'products': {
            'title': cartProducts[0].title,
            'price': cartProducts[0].price,
            'quantity': cartProducts[0].quantity,
          },
        }),
      );

      final newOrder = OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: dateTime,
        products: cartProducts,
      );

      _orders.add(newOrder);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchAndSetOrders() async {}
}
