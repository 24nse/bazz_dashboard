import 'dart:convert';
import 'dart:js_interop';

@JS('addProductToFirestore')
external JSPromise<JSString> _jsAddProductToFirestore(JSString jsonStr);

@JS('getProductsFromFirestore')
external JSPromise<JSString> _jsGetProductsFromFirestore(JSString? colName);

@JS('checkCollectionStatus')
external JSPromise<JSString> _jsCheckCollectionStatus(JSString colName);

@JS('getFirebaseConfig')
external JSString _jsGetFirebaseConfig();

@JS('setFirebaseConfig')
external JSString _jsSetFirebaseConfig(JSString jsonStr);

class FirebaseService {
  static const String defaultProjectId = 'lipsak-97e24';
  static const String defaultCollection = 'Products';

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

  /// Save a product to Firestore in project lipsak
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

  /// Fetch all products from Firestore
  static Future<List<Map<String, dynamic>>> getProducts({String? collection}) async {
    try {
      final col = (collection ?? defaultCollection).toJS;
      final promise = _jsGetProductsFromFirestore(col);
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
