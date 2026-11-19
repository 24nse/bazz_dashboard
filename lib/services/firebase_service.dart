import 'dart:convert';
import 'dart:js_interop';

@JS('addProductToFirestore')
external JSPromise<JSString> _jsAddProductToFirestore(JSString jsonStr);

@JS('getProductsFromFirestore')
external JSPromise<JSString> _jsGetProductsFromFirestore(JSString? colName, JSString? storeId);

@JS('updateProductInFirestore')
external JSPromise<JSString> _jsUpdateProductInFirestore(JSString docId, JSString updatesJsonStr, JSString? colName);

@JS('deleteProductFromFirestore')
external JSPromise<JSString> _jsDeleteProductFromFirestore(JSString docId, JSString? colName);

@JS('checkCollectionStatus')
external JSPromise<JSString> _jsCheckCollectionStatus(JSString colName);

@JS('getFirebaseConfig')
external JSString _jsGetFirebaseConfig();

@JS('setFirebaseConfig')
external JSString _jsSetFirebaseConfig(JSString jsonStr);

class FirebaseService {
  static const String defaultProjectId = 'lipsak-97e24';
  static const String defaultCollection = 'products'; // Root Collection 'products'

  /// Check whether a collection exists and is accessible
  static Future<Map<String, dynamic>> checkCollection(String collectionName) async {
    try {
      final promise = _jsCheckCollectionStatus(collectionName.toJS);
      final jsResult = await promise.toDart;
      return jsonDecode(jsResult.toDart) as Map<String, dynamic>;
    } catch (e) {
      return {
        'success': false,
        'exists': false,
        'error': e.toString(),
        'collection': collectionName,
      };
    }
  }

  /// Save a product to Firestore in root collection 'products'
  static Future<Map<String, dynamic>> addProduct(Map<String, dynamic> productData) async {
    try {
      final jsonStr = jsonEncode(productData);
      final promise = _jsAddProductToFirestore(jsonStr.toJS);
      final jsResult = await promise.toDart;
      final resultStr = jsResult.toDart;
      final decoded = jsonDecode(resultStr) as Map<String, dynamic>;
      return decoded;
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Fetch products from Firestore with optional storeId filtering
  static Future<List<Map<String, dynamic>>> getProducts({
    String? storeId,
    String? collection,
  }) async {
    try {
      final col = (collection ?? defaultCollection).toJS;
      final sId = storeId != null && storeId.isNotEmpty ? storeId.toJS : null;
      final promise = _jsGetProductsFromFirestore(col, sId);
      final jsResult = await promise.toDart;
      final resultStr = jsResult.toDart;
      final data = jsonDecode(resultStr) as Map<String, dynamic>;
      if (data['success'] == true && data['products'] is List) {
        return List<Map<String, dynamic>>.from(data['products']);
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  /// Update a product in Firestore (e.g. stock, price, salePrice)
  static Future<Map<String, dynamic>> updateProduct(
    String docId,
    Map<String, dynamic> updates, {
    String? collection,
  }) async {
    try {
      final id = docId.toJS;
      final updatesStr = jsonEncode(updates).toJS;
      final col = (collection ?? defaultCollection).toJS;
      final promise = _jsUpdateProductInFirestore(id, updatesStr, col);
      final jsResult = await promise.toDart;
      final resultStr = jsResult.toDart;
      return jsonDecode(resultStr) as Map<String, dynamic>;
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Delete a product document from Firestore root collection 'products'
  static Future<Map<String, dynamic>> deleteProduct(
    String docId, {
    String? collection,
  }) async {
    try {
      final id = docId.toJS;
      final col = (collection ?? defaultCollection).toJS;
      final promise = _jsDeleteProductFromFirestore(id, col);
      final jsResult = await promise.toDart;
      final resultStr = jsResult.toDart;
      return jsonDecode(resultStr) as Map<String, dynamic>;
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Get current Firebase config
  static Map<String, dynamic> getConfig() {
    try {
      final jsStr = _jsGetFirebaseConfig();
      return jsonDecode(jsStr.toDart) as Map<String, dynamic>;
    } catch (_) {
      return {
        'apiKey': '',
        'projectId': defaultProjectId,
        'authDomain': '$defaultProjectId.firebaseapp.com',
      };
    }
  }

  /// Save updated Firebase config to localStorage & reinit
  static bool setConfig(Map<String, dynamic> config) {
    try {
      final jsResult = _jsSetFirebaseConfig(jsonEncode(config).toJS);
      final decoded = jsonDecode(jsResult.toDart) as Map<String, dynamic>;
      return decoded['success'] == true;
    } catch (_) {
      return false;
    }
  }
}
