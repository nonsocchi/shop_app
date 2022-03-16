import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart' as od;
import '../widgets/drawer.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const MainDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, i) => od.OrderItem(
          order: orderData.orders[i],
        ),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
