import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductCard extends StatelessWidget {

  final Product product;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,

      child: Card(
        elevation: 5,

        child: Padding(
          padding: const EdgeInsets.all(8),

          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,

                child: IconButton(
                  onPressed: onFavoriteToggle,

                  icon: Icon(
                    product.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,

                    color:
                        product.isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
              ),

              Expanded(
                child: Image.network(
                  product.image,

                  fit: BoxFit.contain,

                  loadingBuilder:
                      (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },

                  errorBuilder:
                      (context, error, stackTrace) {
                    return const Icon(
                      Icons.error,
                      size: 50,
                      color: Colors.red,
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "\$${product.price}",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}