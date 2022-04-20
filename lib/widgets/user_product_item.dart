import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes/edit_product_screen.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  final String? id;
  final String? title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final deletedScaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title!),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100.0,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              icon: const Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(id!);
                } catch (error) {
                  deletedScaffold.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Deleting Failed!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}
