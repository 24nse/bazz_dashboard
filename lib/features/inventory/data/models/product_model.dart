/// Domain Model representing a single Product in the Inventory.
library;

class ProductModel {
  final String id;
  final String nameAr;
  final String nameEn;
  final String sku;
  final String brand;
  final String category;
  final double price;
  final double? discountPrice;
  final int stock;
  final String imageUrl;
  final bool isPublished;
  final String? sales;

  const ProductModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.sku,
    required this.brand,
    required this.category,
    required this.price,
    this.discountPrice,
    required this.stock,
    required this.imageUrl,
    required this.isPublished,
    this.sales,
  });

  /// Factory constructor to map Firestore document data into a typed [ProductModel].
  factory ProductModel.fromMap(Map<String, dynamic> data, [String? id]) {
    final parsedPrice = _parseDouble(data['price']);
    final parsedDiscount = data['discountPrice'] != null ? _parseDouble(data['discountPrice']) : null;
    final parsedStock = (data['stock'] is num) ? (data['stock'] as num).toInt() : 0;

    return ProductModel(
      id: id ?? data['id']?.toString() ?? '',
      nameAr: (data['nameAr'] ?? '').toString(),
      nameEn: (data['nameEn'] ?? '').toString(),
      sku: (data['sku'] ?? 'N/A').toString(),
      brand: (data['brand'] ?? 'متجر نبض').toString(),
      category: (data['category'] ?? 'عام').toString(),
      price: parsedPrice,
      discountPrice: (parsedDiscount != null && parsedDiscount > 0 && parsedDiscount != parsedPrice)
          ? parsedDiscount
          : null,
      stock: parsedStock,
      imageUrl: (data['imageUrl'] != null && data['imageUrl'].toString().isNotEmpty)
          ? data['imageUrl'].toString()
          : 'https://lh3.googleusercontent.com/aida-public/AB6AXuDWnaA1xderq1MlEPMwI9HNmHkmJW71LkSgseqGGboAEwdE-_wFaxzVPNtGUB0QMWakdritPZ4b9eKQqA1cCr74EHpJmdNws0zBmoOP8nW7v-5yulYG5WO_LunNrqSZYW8FOA45E2nfPjXvtp4eggUysjR5AmC2AJUMRmNjFdl5wv_4GZqk7a1pVxaDuTbhNcIbELLqAnTcIhTqzGQxdkAbjd6r0egLM0bN_8IgjpT_3c_BkTYczcaY',
      isPublished: data['isPublished'] == true,
      sales: data['sales']?.toString(),
    );
  }

  /// Convert to Map for saving/updating to Firestore.
  Map<String, dynamic> toMap() {
    return {
      'nameAr': nameAr,
      'nameEn': nameEn,
      'sku': sku,
      'brand': brand,
      'category': category,
      'price': price,
      if (discountPrice != null) 'discountPrice': discountPrice,
      'stock': stock,
      'imageUrl': imageUrl,
      'isPublished': isPublished,
      if (sales != null) 'sales': sales,
    };
  }

  /// Display title fallback
  String get displayName {
    if (nameAr.isNotEmpty) return nameAr;
    if (nameEn.isNotEmpty) return nameEn;
    return 'منتج بدون اسم';
  }

  /// Business logic helpers
  bool get isOutOfStock => stock <= 0;
  bool get isLowStock => stock > 0 && stock <= 10;
  double get effectivePrice => discountPrice ?? price;

  static double _parseDouble(dynamic val) {
    if (val is num) return val.toDouble();
    if (val is String) {
      final parsed = double.tryParse(val);
      if (parsed != null) return parsed;
    }
    return 0.0;
  }
}
