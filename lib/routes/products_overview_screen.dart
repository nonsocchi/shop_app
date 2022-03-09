import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

enum FilterOptions { favourites, all }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavourites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Shop'), actions: [
        PopupMenuButton(
          onSelected: (FilterOptions selectedValue) {
            setState(() {
              if (selectedValue == FilterOptions.favourites) {
                _showOnlyFavourites = true;
              } else {
                _showOnlyFavourites = false;
              }
            });
          },
          icon: const Icon(
            Icons.more_vert,
          ),
          itemBuilder: (_) => [
            const PopupMenuItem(
              child: Text('Only Favourites'),
              value: FilterOptions.favourites,
            ),
            const PopupMenuItem(
              child: Text('Show all'),
              value: FilterOptions.all,
            ),
          ],
        ),
      ]),
      body: ProductsGrid(showFavs: _showOnlyFavourites),
    );
  }
}
