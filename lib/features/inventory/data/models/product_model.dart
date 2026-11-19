/// Product Model strictly adhering to the flat NoSQL Firestore schema for 'products'.
library;

class ProductModel {
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

  const ProductModel({
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

  /// Factory constructor to map Firestore Document or Map into typed [ProductModel].
  /// Supports DocumentSnapshot, Map<String, dynamic>, and REST API structures.
  factory ProductModel.fromFirestore(dynamic doc, [dynamic options]) {
    if (doc == null) {
      return ProductModel.empty();
    }

    if (doc is Map<String, dynamic>) {
      return ProductModel.fromMap(doc);
    }

    // Handles DocumentSnapshot from cloud_firestore or dynamic JS object
    try {
      final dynamic dataGetter = (doc as dynamic).data;
      final Map<String, dynamic> data = (dataGetter is Function ? dataGetter() : null) as Map<String, dynamic>? ?? {};
      final String docId = (doc as dynamic).id?.toString() ?? '';
      return ProductModel.fromMap(data, docId);
    } catch (_) {
      return ProductModel.empty();
    }
  }

  /// Factory constructor to map raw Firestore document data map.
  factory ProductModel.fromMap(Map<String, dynamic> data, [String? id]) {
    final parsedPrice = _parseDouble(data['price'] ?? data['Price']);
    final parsedSalePrice = _parseDouble(data['salePrice'] ?? data['SalePrice'] ?? data['discountPrice']);
    final parsedStock = _parseInt(data['stock'] ?? data['Stock']);
    final parsedRating = _parseDouble(data['rating'] ?? 0.0);
    final parsedReviewsCount = _parseInt(data['reviewsCount'] ?? 0);

    // Parse gallery images list safely
    List<String> parsedImages = [];
    if (data['images'] is List) {
      parsedImages = (data['images'] as List).map((e) => e.toString()).toList();
    }

    final thumb = (data['thumbnail'] ?? data['Thumbnail'] ?? data['imageUrl'] ?? '').toString();
    if (parsedImages.isEmpty && thumb.isNotEmpty) {
      parsedImages = [thumb];
    }

    // Auto-compute saleLabel fallback if salePrice is lower than price
    String sLabel = (data['saleLabel'] ?? '').toString();
    if (sLabel.isEmpty && parsedSalePrice > 0 && parsedSalePrice < parsedPrice) {
      final discountPct = (((parsedPrice - parsedSalePrice) / parsedPrice) * 100).round();
      sLabel = 'خصم $discountPct%';
    }

    final pTitle = (data['title'] ?? data['Title'] ?? data['nameAr'] ?? data['name'] ?? '').toString();

    return ProductModel(
      id: id ?? data['id']?.toString() ?? '',
      storeId: (data['storeId'] ?? '').toString(),
      vendorId: (data['vendorId'] ?? '').toString(),
      categoryId: (data['categoryId'] ?? data['category'] ?? '').toString(),
      topTab: (data['topTab'] ?? 'men').toString(),
      title: pTitle,
      description: (data['description'] ?? data['Description'] ?? '').toString(),
      thumbnail: thumb.isNotEmpty
          ? thumb
          : 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=500',
      images: parsedImages,
      price: parsedPrice,
      salePrice: parsedSalePrice,
      saleLabel: sLabel,
      stock: parsedStock,
      rating: parsedRating,
      reviewsCount: parsedReviewsCount,
      isFeatured: data['isFeatured'] == true || data['IsFeatured'] == true,
      isActive: data['isActive'] ?? true,
      createdAt: data['createdAt'] ?? data['CreatedAt'],
    );
  }

  /// Convert to exact Firestore Map matching the schema strictly.
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

  /// Alias for toFirestore
  Map<String, dynamic> toMap() => toFirestore();

  /// Create an empty instance for fallbacks
  factory ProductModel.empty() {
    return const ProductModel(
      storeId: '',
      vendorId: '',
      categoryId: '',
      topTab: 'men',
      title: '',
      thumbnail: '',
      price: 0.0,
    );
  }

  /// CopyWith helper for immutable state updates
  ProductModel copyWith({
    String? id,
    String? storeId,
    String? vendorId,
    String? categoryId,
    String? topTab,
    String? title,
    String? description,
    String? thumbnail,
    List<String>? images,
    double? price,
    double? salePrice,
    String? saleLabel,
    int? stock,
    double? rating,
    int? reviewsCount,
    bool? isFeatured,
    bool? isActive,
    dynamic createdAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      vendorId: vendorId ?? this.vendorId,
      categoryId: categoryId ?? this.categoryId,
      topTab: topTab ?? this.topTab,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      images: images ?? this.images,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      saleLabel: saleLabel ?? this.saleLabel,
      stock: stock ?? this.stock,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      isFeatured: isFeatured ?? this.isFeatured,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // --- Display & Compatibility Helpers ---
  String get displayName => title.isNotEmpty ? title : 'منتج بدون اسم';
  String get imageUrl => thumbnail;
  String get category => categoryId;
  String get sku => id.isNotEmpty ? id : 'PRD-${title.hashCode.abs().toString().substring(0, 5)}';
  String get brand => topTab;
  double? get discountPrice => (salePrice > 0 && salePrice < price) ? salePrice : null;
  bool get isPublished => isActive;
  String? get sales => 'مبيعات: 0';

  bool get isOutOfStock => stock <= 0;
  bool get isLowStock => stock > 0 && stock <= 10;
  double get effectivePrice => (salePrice > 0 && salePrice < price) ? salePrice : price;
  bool get hasDiscount => salePrice > 0 && salePrice < price;

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
