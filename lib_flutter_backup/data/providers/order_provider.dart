import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order.dart';
import '../dummy_data/dummy_orders.dart';

final ordersProvider = FutureProvider<List<Order>>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  return dummyOrders;
});
