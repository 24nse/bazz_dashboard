/// Exact Product model for Flutter codebase matching root collection 'products'.
library;

class Product {
  final String id;
  final String storeId;
  final String vendorId;
  final String categoryId;
  final String topTab;
  final String title;
  final String description;
  final String thumbnail;
  final List<String> images;
  final double price;
  final double salePrice;
  final String saleLabel;
  final int stock;
  final double rating;
  final int reviewsCount;
  final bool isFeatured;
  final bool isActive;
  final dynamic createdAt;

  Product({
    this.id = '',
    required this.storeId,
    required this.vendorId,
    required this.categoryId,
    required this.topTab,
    required this.title,
    this.description = '',
    required this.thumbnail,
    this.images = const [],
    required this.price,
    this.salePrice = 0.0,
    this.saleLabel = '',
    this.stock = 0,
    this.rating = 0.0,
    this.reviewsCount = 0,
    this.isFeatured = false,
    this.isActive = true,
    this.createdAt,
  });

  /// Factory constructor to map Firestore Document or Map
  factory Product.fromFirestore(dynamic doc) {
    if (doc is Map<String, dynamic>) {
      return Product.fromMap(doc);
    }
    try {
      final dynamic dataGetter = (doc as dynamic).data;
      final Map<String, dynamic> data = (dataGetter is Function ? dataGetter() : null) as Map<String, dynamic>? ?? {};
      final String docId = (doc as dynamic).id?.toString() ?? '';
      return Product.fromMap(data, docId);
    } catch (_) {
      return Product.empty();
    }
  }

  factory Product.fromMap(Map<String, dynamic> data, [String? id]) {
    final parsedPrice = _parseDouble(data['price'] ?? data['Price']);
    final parsedSalePrice = _parseDouble(data['salePrice'] ?? data['SalePrice'] ?? data['discountPrice']);
    final parsedStock = _parseInt(data['stock'] ?? data['Stock']);

    List<String> parsedImages = [];
    if (data['images'] is List) {
      parsedImages = (data['images'] as List).map((e) => e.toString()).toList();
    }
    final thumb = (data['thumbnail'] ?? data['Thumbnail'] ?? data['imageUrl'] ?? '').toString();
    if (parsedImages.isEmpty && thumb.isNotEmpty) {
      parsedImages = [thumb];
    }

    String sLabel = (data['saleLabel'] ?? '').toString();
    if (sLabel.isEmpty && parsedSalePrice > 0 && parsedSalePrice < parsedPrice) {
      final pct = (((parsedPrice - parsedSalePrice) / parsedPrice) * 100).round();
      sLabel = 'خصم $pct%';
    }

    return Product(
      id: id ?? data['id']?.toString() ?? '',
      storeId: (data['storeId'] ?? '').toString(),
      vendorId: (data['vendorId'] ?? '').toString(),
      categoryId: (data['categoryId'] ?? data['category'] ?? '').toString(),
      topTab: (data['topTab'] ?? 'women').toString(),
      title: (data['title'] ?? data['name'] ?? data['nameAr'] ?? '').toString(),
      description: (data['description'] ?? '').toString(),
      thumbnail: thumb,
      images: parsedImages,
      price: parsedPrice,
      salePrice: parsedSalePrice,
      saleLabel: sLabel,
      stock: parsedStock,
      rating: _parseDouble(data['rating'] ?? 0.0),
      reviewsCount: _parseInt(data['reviewsCount'] ?? 0),
      isFeatured: data['isFeatured'] == true,
      isActive: data['isActive'] ?? true,
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'storeId': storeId,
      'vendorId': vendorId,
      'categoryId': categoryId,
      'topTab': topTab,
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
      'images': images,
      'price': price,
      'salePrice': salePrice,
      'saleLabel': saleLabel,
      'stock': stock,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'isFeatured': isFeatured,
      'isActive': isActive,
      'createdAt': createdAt ?? 'SERVER_TIMESTAMP',
    };
  }

  Map<String, dynamic> toMap() => toFirestore();

  factory Product.empty() {
    return Product(
      storeId: '',
      vendorId: '',
      categoryId: '',
      topTab: 'women',
      title: '',
      thumbnail: '',
      price: 0.0,
    );
  }

  // Backwards compatibility getters
  String get name => title;
  String get imageUrl => thumbnail;
  String get category => categoryId;

  static double _parseDouble(dynamic val) {
    if (val is num) return val.toDouble();
    if (val is String) {
      final parsed = double.tryParse(val);
      if (parsed != null) return parsed;
    }
    return 0.0;
  }

  static int _parseInt(dynamic val) {
    if (val is num) return val.toInt();
    if (val is String) {
      final parsed = int.tryParse(val);
      if (parsed != null) return parsed;
    }
    return 0;
  }
}
