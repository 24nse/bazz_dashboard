import 'dart:async';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import '../../../../services/firebase_service.dart';
import '../models/product_model.dart';

/// Abstract contract for inventory data operations.
abstract class InventoryRepository {
  Future<List<ProductModel>> fetchProducts({String? collection});
  Future<Map<String, dynamic>> addProduct(ProductModel product);
  Stream<List<ProductModel>> watchProducts({String? collection, Duration pollInterval});
}

/// Firebase Firestore implementation of [InventoryRepository].
class FirebaseInventoryRepository implements InventoryRepository {
  @override
  Future<List<ProductModel>> fetchProducts({String? collection}) async {
    try {
      final rawList = await FirebaseService.getProducts(collection: collection);
      return rawList.map((item) => ProductModel.fromMap(item)).toList();
    } catch (e) {
      // Re-throw or return empty depending on architectural choice
      throw Exception('فشل في جلب المنتجات من Firestore: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> addProduct(ProductModel product) async {
    return await FirebaseService.addProduct(product.toMap());
  }

  @override
  Stream<List<ProductModel>> watchProducts({
    String? collection,
    Duration pollInterval = const Duration(seconds: 30),
  }) async* {
    // Initial emission
    yield await fetchProducts(collection: collection);

    // Periodic live sync stream for dashboard live metrics
    while (true) {
      await Future.delayed(pollInterval);
      try {
        final products = await fetchProducts(collection: collection);
        yield products;
      } catch (_) {
        // Stream continues on network blips
      }
    }
  }
}

/// Riverpod Provider providing access to the Inventory Repository.
final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  return FirebaseInventoryRepository();
});
