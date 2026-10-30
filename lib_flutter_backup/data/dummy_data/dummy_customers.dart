import '../models/customer.dart';

final List<Customer> dummyCustomers = [
  Customer(id: 'C001', name: 'Alice Johnson', email: 'alice.j@example.com', lifetimeSpend: 1245.00, lastActive: DateTime.now().subtract(const Duration(days: 2))),
  Customer(id: 'C002', name: 'Bob Smith', email: 'bsmith99@example.com', lifetimeSpend: 340.50, lastActive: DateTime.now().subtract(const Duration(days: 14))),
  Customer(id: 'C003', name: 'Charlie Brown', email: 'charlie.b@example.com', lifetimeSpend: 89.00, lastActive: DateTime.now().subtract(const Duration(hours: 5))),
  Customer(id: 'C004', name: 'Diana Prince', email: 'dprince@example.com', lifetimeSpend: 4560.75, lastActive: DateTime.now().subtract(const Duration(minutes: 30))),
];
