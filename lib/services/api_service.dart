import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com/products';

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);

      return jsonData
          .map((product) => Product.fromJson(product))
          .toList();
    } else {
      throw Exception('Ürünler yüklenemedi');
    }
  }
}