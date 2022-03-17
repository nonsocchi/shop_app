import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.title,
  }) : super(key: key);

  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) =>
          Provider.of<Cart>(context, listen: false).removeItems(productId),
      confirmDismiss: (direction) => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Are you sure?'),
          content: Text('Proceed to remove $title from the cart?'),
          elevation: 10.0,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('No'),
            ),
          ],
        ),
      ),
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      background: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).errorColor,
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40.0,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        margin: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 4.0,
        ),
      ),
      child: Card(
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
      ),
    );
  }
}
