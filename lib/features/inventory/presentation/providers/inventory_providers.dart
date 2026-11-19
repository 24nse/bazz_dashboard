import 'dart:async';
import 'package:jaspr_riverpod/jaspr_riverpod.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/inventory_repository.dart';

/// StateNotifier managing asynchronous fetching, caching, and refreshing of products.
class ProductsNotifier extends AsyncNotifier<List<ProductModel>> {
  @override
  FutureOr<List<ProductModel>> build() async {
    return _fetchProducts();
  }

  Future<List<ProductModel>> _fetchProducts() async {
    final repo = ref.read(inventoryRepositoryProvider);
    return await repo.fetchProducts();
  }

  /// Manually triggers a reload of the products list with loading state.
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchProducts());
  }

  /// Add a product and automatically refresh state.
  Future<bool> addProduct(ProductModel product) async {
    final repo = ref.read(inventoryRepositoryProvider);
    final result = await repo.addProduct(product);
    if (result['success'] == true) {
      await refresh();
      return true;
    }
    return false;
  }
}

/// Global AsyncNotifierProvider for products inventory.
final productsNotifierProvider =
    AsyncNotifierProvider<ProductsNotifier, List<ProductModel>>(
  ProductsNotifier.new,
);

/// Optional Live StreamProvider for reactive background updates.
final liveInventoryStreamProvider = StreamProvider<List<ProductModel>>((ref) {
  final repo = ref.watch(inventoryRepositoryProvider);
  return repo.watchProducts();
});

/// Search query state for local filtering.
final productSearchQueryProvider = Provider<String>((ref) => '');

// --- KPI Selectors (Zero business logic inside UI components) ---

/// Total number of products in Firestore.
final totalProductsCountProvider = Provider<int>((ref) {
  final asyncState = ref.watch(productsNotifierProvider);
  return asyncState.maybeWhen(
    data: (list) => list.length,
    orElse: () => 0,
  );
});

/// Number of active (published) products.
final activeProductsCountProvider = Provider<int>((ref) {
  final asyncState = ref.watch(productsNotifierProvider);
  return asyncState.maybeWhen(
    data: (list) => list.where((p) => p.isPublished).length,
    orElse: () => 0,
  );
});

/// Number of products with low stock (<= 10) or out of stock (0).
final lowStockProductsCountProvider = Provider<int>((ref) {
  final asyncState = ref.watch(productsNotifierProvider);
  return asyncState.maybeWhen(
    data: (list) => list.where((p) => p.isLowStock || p.isOutOfStock).length,
    orElse: () => 0,
  );
});
