/// Store Model strictly adhering to the flat NoSQL Firestore schema for 'stores'.
library;

class StoreModel {
  final String id;
  final String vendorId;
  final String name;
  final String logo;
  final String coverImage;
  final String phone;
  final String city;
  final String address;
  final bool isActive;

  const StoreModel({
    this.id = '',
    required this.vendorId,
    required this.name,
    this.logo = '',
    this.coverImage = '',
    this.phone = '',
    this.city = '',
    this.address = '',
    this.isActive = true,
  });

  /// Factory constructor to map Firestore Document or Map into typed [StoreModel].
  /// Supports DocumentSnapshot, `Map<String, dynamic>`, and REST API structures.
  factory StoreModel.fromFirestore(dynamic doc, [dynamic options]) {
    if (doc == null) {
      return StoreModel.empty();
    }

    if (doc is Map<String, dynamic>) {
      return StoreModel.fromMap(doc);
    }

    try {
      final dynamic dataGetter = (doc as dynamic).data;
      final Map<String, dynamic> data = (dataGetter is Function ? dataGetter() : null) as Map<String, dynamic>? ?? {};
      final String docId = (doc as dynamic).id?.toString() ?? '';
      return StoreModel.fromMap(data, docId);
    } catch (_) {
      return StoreModel.empty();
    }
  }

  /// Factory constructor to map raw Firestore document data map.
  factory StoreModel.fromMap(Map<String, dynamic> data, [String? id]) {
    return StoreModel(
      id: id ?? data['id']?.toString() ?? '',
      vendorId: (data['vendorId'] ?? '').toString(),
      name: (data['name'] ?? '').toString(),
      logo: (data['logo'] ?? '').toString(),
      coverImage: (data['coverImage'] ?? '').toString(),
      phone: (data['phone'] ?? '').toString(),
      city: (data['city'] ?? '').toString(),
      address: (data['address'] ?? '').toString(),
      isActive: data['isActive'] ?? true,
    );
  }

  /// Convert to exact Firestore Map matching the schema strictly.
  Map<String, dynamic> toFirestore() {
    return {
      'vendorId': vendorId,
      'name': name,
      'logo': logo,
      'coverImage': coverImage,
      'phone': phone,
      'city': city,
      'address': address,
      'isActive': isActive,
    };
  }

  /// Alias for toFirestore
  Map<String, dynamic> toMap() => toFirestore();

  /// Create an empty instance for fallbacks
  factory StoreModel.empty() {
    return const StoreModel(
      vendorId: '',
      name: '',
    );
  }

  /// CopyWith helper for immutable state updates
  StoreModel copyWith({
    String? id,
    String? vendorId,
    String? name,
    String? logo,
    String? coverImage,
    String? phone,
    String? city,
    String? address,
    bool? isActive,
  }) {
    return StoreModel(
      id: id ?? this.id,
      vendorId: vendorId ?? this.vendorId,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      coverImage: coverImage ?? this.coverImage,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      address: address ?? this.address,
      isActive: isActive ?? this.isActive,
    );
  }
}
