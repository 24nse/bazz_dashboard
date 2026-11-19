/// Exact Store model matching root collection 'stores'.
library;

class Store {
  final String id;
  final String vendorId;
  final String name;
  final String logo;
  final String coverImage;
  final String phone;
  final String city;
  final String address;
  final bool isActive;

  Store({
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

  factory Store.fromFirestore(dynamic doc) {
    if (doc is Map<String, dynamic>) {
      return Store.fromMap(doc);
    }
    try {
      final dynamic dataGetter = (doc as dynamic).data;
      final Map<String, dynamic> data = (dataGetter is Function ? dataGetter() : null) as Map<String, dynamic>? ?? {};
      final String docId = (doc as dynamic).id?.toString() ?? '';
      return Store.fromMap(data, docId);
    } catch (_) {
      return Store.empty();
    }
  }

  factory Store.fromMap(Map<String, dynamic> data, [String? id]) {
    return Store(
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

  Map<String, dynamic> toMap() => toFirestore();

  factory Store.empty() {
    return Store(
      vendorId: '',
      name: '',
    );
  }
}
