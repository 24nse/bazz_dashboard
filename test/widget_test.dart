import 'package:bazz_dashboard/features/inventory/data/models/product_model.dart';
import 'package:bazz_dashboard/features/inventory/data/models/store_model.dart';

void main() {
  // Test ProductModel creation and Firestore serialization
  final product = ProductModel(
    id: 'prod_01',
    storeId: 'store_01',
    vendorId: 'vendor_01',
    categoryId: 'women_dresses',
    topTab: 'women',
    title: 'فستان سهرة كريب راقي',
    description: 'فستان سهرة نسائي مصمم من خامة الكريب الفاخرة',
    thumbnail: 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=500',
    images: ['https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=500'],
    price: 299.0,
    salePrice: 239.0,
    saleLabel: 'خصم 20%',
    stock: 25,
    rating: 0.0,
    reviewsCount: 0,
    isFeatured: true,
    isActive: true,
  );

  final firestoreMap = product.toFirestore();
  assert(firestoreMap['storeId'] == 'store_01');
  assert(firestoreMap['vendorId'] == 'vendor_01');
  assert(firestoreMap['categoryId'] == 'women_dresses');
  assert(firestoreMap['topTab'] == 'women');
  assert(firestoreMap['title'] == 'فستان سهرة كريب راقي');
  assert(firestoreMap['price'] == 299.0);
  assert(firestoreMap['salePrice'] == 239.0);
  assert(firestoreMap['stock'] == 25);
  assert(firestoreMap['isFeatured'] == true);
  assert(firestoreMap['isActive'] == true);

  // Test fromFirestore / fromMap roundtrip
  final restoredProduct = ProductModel.fromFirestore(firestoreMap);
  assert(restoredProduct.storeId == 'store_01');
  assert(restoredProduct.categoryId == 'women_dresses');
  assert(restoredProduct.topTab == 'women');
  assert(restoredProduct.price == 299.0);
  assert(restoredProduct.salePrice == 239.0);
  assert(restoredProduct.stock == 25);

  // Test StoreModel creation and Firestore serialization
  final store = StoreModel(
    id: 'store_01',
    vendorId: 'vendor_01',
    name: 'متجر نبض',
    logo: 'https://example.com/logo.png',
    city: 'الرياض',
    address: 'شارع الملك فهد',
    isActive: true,
  );

  final storeMap = store.toFirestore();
  assert(storeMap['vendorId'] == 'vendor_01');
  assert(storeMap['name'] == 'متجر نبض');
  assert(storeMap['city'] == 'الرياض');
  assert(storeMap['isActive'] == true);

  final restoredStore = StoreModel.fromFirestore(storeMap);
  assert(restoredStore.vendorId == 'vendor_01');
  assert(restoredStore.name == 'متجر نبض');
}
