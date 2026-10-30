enum OrderStatus { processing, shipped, delivered, cancelled }

class Order {
  final String id;
  final String customerName;
  final double totalAmount;
  final DateTime date;
  final OrderStatus status;

  Order({
    required this.id,
    required this.customerName,
    required this.totalAmount,
    required this.date,
    required this.status,
  });
}
