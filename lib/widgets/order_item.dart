import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  const OrderItem({Key? key, required this.order}) : super(key: key);

  final ord.OrderItem order;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '\$${widget.order.amount}',
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
                height: min(widget.order.products.length * 20.0 + 100.0, 100.0),
                child: ListView(
                  children: widget.order.products
                      .map((prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                prod.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              Text(
                                '${prod.quantity}x \$${prod.price}',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ))
                      .toList(),
                ))
        ],
      ),
    );
  }
}
