import 'dart:async';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import '../../../../services/firebase_service.dart';
import '../models/product_model.dart';

/// Abstract contract for inventory and product data operations strictly targeting 'products' root collection.
abstract class InventoryRepository {
  /// Fetch all products or filter by vendor's [storeId].
  Future<List<ProductModel>> fetchProducts({String? storeId, String? collection});

  /// Read a single product by [id].
  Future<ProductModel?> getProductById(String id, {String? collection});

  /// Add a new product to 'products' root collection.
  Future<Map<String, dynamic>> addProduct(ProductModel product);

  /// Update arbitrary fields of a product by [productId].
  Future<Map<String, dynamic>> updateProduct(String productId, Map<String, dynamic> updates);

  /// Specialized update method for inventory attributes: [stock], [price], and [salePrice].
  Future<Map<String, dynamic>> updateInventory(
    String productId, {
    int? stock,
    double? price,
    double? salePrice,
  });

  /// Delete a product document by [productId] from 'products' root collection.
  Future<Map<String, dynamic>> deleteProduct(String productId);

  /// Reactive stream for real-time dashboard syncing.
  Stream<List<ProductModel>> watchProducts({
    String? storeId,
    String? collection,
    Duration pollInterval,
  });
}

/// Firebase Firestore implementation of [InventoryRepository].
class FirebaseInventoryRepository implements InventoryRepository {
  @override
  Future<List<ProductModel>> fetchProducts({String? storeId, String? collection}) async {
    try {
      final rawList = await FirebaseService.getProducts(
        storeId: storeId,
        collection: collection ?? FirebaseService.defaultCollection,
      );
      return rawList.map((item) => ProductModel.fromMap(item)).toList();
    } catch (e) {
      throw Exception('فشل في جلب المنتجات من Firestore: $e');
    }
  }

  @override
  Future<ProductModel?> getProductById(String id, {String? collection}) async {
    final list = await fetchProducts(collection: collection);
    try {
      return list.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>> addProduct(ProductModel product) async {
    return await FirebaseService.addProduct(product.toFirestore());
  }

  @override
  Future<Map<String, dynamic>> updateProduct(String productId, Map<String, dynamic> updates) async {
    return await FirebaseService.updateProduct(productId, updates);
  }

  @override
  Future<Map<String, dynamic>> updateInventory(
    String productId, {
    int? stock,
    double? price,
    double? salePrice,
  }) async {
    final updates = <String, dynamic>{};
    if (stock != null) updates['stock'] = stock;
    if (price != null) updates['price'] = price;
    if (salePrice != null) {
      updates['salePrice'] = salePrice;
      if (price != null && price > 0 && salePrice < price) {
        final pct = (((price - salePrice) / price) * 100).round();
        updates['saleLabel'] = 'خصم $pct%';
      }
    }
    return await updateProduct(productId, updates);
  }

  @override
  Future<Map<String, dynamic>> deleteProduct(String productId) async {
    return await FirebaseService.deleteProduct(productId);
  }

  @override
  Stream<List<ProductModel>> watchProducts({
    String? storeId,
    String? collection,
    Duration pollInterval = const Duration(seconds: 30),
  }) async* {
    yield await fetchProducts(storeId: storeId, collection: collection);

    while (true) {
      await Future.delayed(pollInterval);
      try {
        final products = await fetchProducts(storeId: storeId, collection: collection);
        yield products;
      } catch (_) {
        // Continue stream silently on temporary network issues
      }
    }
  }
}

/// Riverpod Provider providing access to the Inventory Repository.
final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  return FirebaseInventoryRepository();
});
