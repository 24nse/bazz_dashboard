import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/customer.dart';
import '../dummy_data/dummy_customers.dart';

final customersProvider = FutureProvider<List<Customer>>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  return dummyCustomers;
});
