import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductDetailScreen
    extends StatefulWidget {

  const ProductDetailScreen({
    super.key,
  });

  @override
  State<ProductDetailScreen>
      createState() =>
          _ProductDetailScreenState();
}

class _ProductDetailScreenState
    extends State<ProductDetailScreen> {

  @override
  Widget build(BuildContext context) {

    final product =
        ModalRoute.of(context)!
            .settings
            .arguments as Product;

    return Scaffold(

      appBar: AppBar(
        title: const Text("Ürün Detayı"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Center(
              child: Image.network(
                product.image,
                height: 250,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              product.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "\$${product.price}",
              style: const TextStyle(
                fontSize: 28,
                color: Colors.green,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Kategori: ${product.category}",
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              product.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (product.isInCart) {
                      product.quantity++;
                    } else {
                      product.isInCart = true;
                      product.quantity = 1;
                    }
                  });

                  ScaffoldMessenger.of(
                          context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Ürün sepete eklendi",
                      ),
                    ),
                  );
                },

                child: Text(
                  product.isInCart
                      ? "Sepete Eklendi"
                      : "Sepete Ekle",

                  style:
                      const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}