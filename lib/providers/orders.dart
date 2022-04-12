import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './cart.dart' as cart;

class OrderItem {
  final String id;
  final double amount;
  final List<cart.CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

const url = 'https://shop-app-e7566-default-rtdb.firebaseio.com/orders.json';

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders => [..._orders];

  Future<void> addOrder(List<cart.CartItem> cartProducts, double total) async {
    final timestamp = DateTime.now();

    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      }),
    );

    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
