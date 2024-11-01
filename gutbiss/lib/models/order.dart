import '../models/cart_item.dart';
import '../models/delivery_address.dart';

enum OrderStatus {
  placed,
  confirmed,
  preparing,
  onTheWay,
  delivered,
  cancelled
}

class Order {
  final String id;
  final String restaurantName;
  final List<CartItem> items;
  final DeliveryAddress address;
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final OrderStatus status;
  final DateTime placedAt;
  final String? driverName;
  final String? driverPhone;

  Order({
    required this.id,
    required this.restaurantName,
    required this.items,
    required this.address,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.status,
    required this.placedAt,
    this.driverName,
    this.driverPhone,
  });

  double get total => subtotal + deliveryFee - discount;
} 