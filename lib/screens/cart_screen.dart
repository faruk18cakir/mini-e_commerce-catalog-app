import 'package:flutter/material.dart';

import '../utils/app_data.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() =>
      _CartScreenState();
}

class _CartScreenState
    extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {

    final cartProducts =
        AppData.allProducts
            .where((product) =>
                product.isInCart)
            .toList();

    double totalPrice = 0;
    for (var product in cartProducts) {
      totalPrice +=
          product.price * product.quantity;
    }

    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          title: const Text("Sepet"),
          centerTitle: true,
        ),

        body: cartProducts.isEmpty
            ? const Center(
                child: Text(
                  "Sepet boş",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProducts.length,
                      itemBuilder: (context, index) {
                        final product = cartProducts[index];
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Image.network(
                                  product.image,
                                  width: 70,
                                  height: 70,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "\$${product.price}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (product.quantity > 1) {
                                            product.quantity--;
                                          } else {
                                            product.isInCart = false;
                                          }
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.remove_circle,
                                      ),
                                    ),
                                    Text(
                                      product.quantity.toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          product.quantity++;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.add_circle,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Toplam: \$${totalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Ödeme",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}