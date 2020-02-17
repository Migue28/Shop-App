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
  final String authToken;

  Orders(this.authToken, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = 'https://flutter-shop-app-4bd8d.firebaseio.com/orders.json?auth=$authToken';
    final dateTime = DateTime.now();

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'dateTime': dateTime.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'price': cp.price,
                    'quantity': cp.quantity,
                  })
              .toList(),
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

  Future<void> fetchAndSetOrders() async {
    final url = 'https://flutter-shop-app-4bd8d.firebaseio.com/orders.json?auth=$authToken';

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<OrderItem> loadedOrder = [];

      if(extractedData == null) {
        return;
      }

      extractedData.forEach((ordId, ordData) {
        loadedOrder.add(OrderItem(
          id: ordId,
          amount: ordData['amount'],
          dateTime: DateTime.parse(ordData['dateTime']),
          products: (ordData['products'] as List<dynamic>)
              .map((item) => CartItem(
                    id: item['id'],
                    price: item['price'],
                    quantity: item['quantity'],
                    title: item['title'],
                  ))
              .toList(),
        ));

        _orders = loadedOrder.reversed.toList();
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }
}
