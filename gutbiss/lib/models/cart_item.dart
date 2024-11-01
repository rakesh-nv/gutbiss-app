class CartItem {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final List<String> customizations;
  final String restaurantName;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.customizations,
    required this.restaurantName,
  });

  double get totalPrice => price * quantity;
} 