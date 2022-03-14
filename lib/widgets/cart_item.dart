import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
  }) : super(key: key);

  final String id;
  final double price;
  final int quantity;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 4.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'x $quantity',
              style: const TextStyle(fontSize: 20.0),
            ),
          ),
          title: Text(title),
          subtitle: Text('Total: \$${price * quantity}'),
          trailing: Chip(
            backgroundColor: Theme.of(context).colorScheme.primary,
            label: Text(
              '\$$price',
              style: Theme.of(context).primaryTextTheme.subtitle2,
            ),
          ),
        ),
      ),
    );
  }
}
