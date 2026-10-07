class Customer {
  final String id;
  final String name;
  final String email;
  final double lifetimeSpend;
  final DateTime lastActive;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.lifetimeSpend,
    required this.lastActive,
  });
}
