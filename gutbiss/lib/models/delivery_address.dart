class DeliveryAddress {
  final String id;
  final String name;
  final String address;
  final String details;
  final bool isDefault;

  DeliveryAddress({
    required this.id,
    required this.name,
    required this.address,
    required this.details,
    this.isDefault = false,
  });
} 