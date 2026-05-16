import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';
import '../widgets/product_card.dart';
import '../utils/app_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Product> products = [];

  bool isLoading = true;
  String errorMessage = '';
  String searchText = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      if (AppData.allProducts.isNotEmpty) {
        products = AppData.allProducts;
      } else {
        products =
            await ApiService.fetchProducts();
        AppData.allProducts = products;
      }
    } catch (e) {
      errorMessage =
          'Veriler yüklenirken hata oluştu';
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    final filteredProducts =
        products.where((product) {
      return product.title
          .toLowerCase()
          .contains(
            searchText.toLowerCase(),
          );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mini Katalog"),
        centerTitle: true,
      ),

      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )

    : errorMessage.isNotEmpty

        ? Center(
            child: Text(errorMessage),
          )

        : Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.all(10),

                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },

                  decoration:
                      InputDecoration(

                    hintText:
                        "Ürün ara...",

                    prefixIcon:
                        const Icon(Icons.search),

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                              12),
                    ),
                  ),
                ),
              ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: filteredProducts.length,

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),

              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return ProductCard(
                  product: product,

                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/product-detail',
                      arguments: product,
                    );
                  },

                  onFavoriteToggle: () {
                    setState(() {
                      product.isFavorite =
                          !product.isFavorite;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}