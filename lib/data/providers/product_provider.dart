import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../dummy_data/dummy_products.dart';

final productsProvider = FutureProvider<List<Product>>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  return dummyProducts;
});
