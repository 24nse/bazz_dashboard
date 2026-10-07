import '../models/order.dart';

final List<Order> dummyOrders = [
  Order(id: 'ORD-1025', customerName: 'Alice Johnson', totalAmount: 124.00, date: DateTime.now().subtract(const Duration(minutes: 5)), status: OrderStatus.processing),
  Order(id: 'ORD-1024', customerName: 'Bob Smith', totalAmount: 299.99, date: DateTime.now().subtract(const Duration(hours: 2)), status: OrderStatus.shipped),
  Order(id: 'ORD-1023', customerName: 'Charlie Brown', totalAmount: 45.00, date: DateTime.now().subtract(const Duration(days: 1)), status: OrderStatus.delivered),
  Order(id: 'ORD-1022', customerName: 'Diana Prince', totalAmount: 199.50, date: DateTime.now().subtract(const Duration(days: 1, hours: 4)), status: OrderStatus.cancelled),
  Order(id: 'ORD-1021', customerName: 'Evan Wright', totalAmount: 67.98, date: DateTime.now().subtract(const Duration(days: 2)), status: OrderStatus.delivered),
];
