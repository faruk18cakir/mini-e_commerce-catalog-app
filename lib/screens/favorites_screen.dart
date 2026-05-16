import 'package:flutter/material.dart';

import '../utils/app_data.dart';
import '../widgets/product_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() =>
      _FavoritesScreenState();
}

class _FavoritesScreenState
    extends State<FavoritesScreen> {

  @override
  Widget build(BuildContext context) {
    final favoriteProducts = AppData.allProducts
        .where((product) => product.isFavorite)
        .toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Favoriler"),
          centerTitle: true,
        ),
        body: favoriteProducts.isEmpty
            ? const Center(
                child: Text(
                  "Favori ürün yok",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: favoriteProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = favoriteProducts[index];

                  return ProductCard(
                    product: product,
                    onTap: () {},
                    onFavoriteToggle: () {
                      setState(() {
                        product.isFavorite = false;
                      });
                    },
                  );
                },
              ),
      ),
    );
  }
}