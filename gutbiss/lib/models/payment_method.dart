import 'package:flutter/material.dart';

class PaymentMethod {
  final String id;
  final String type;
  final String lastFourDigits;
  final String expiryDate;
  final bool isDefault;

  PaymentMethod({
    required this.id,
    required this.type,
    required this.lastFourDigits,
    required this.expiryDate,
    this.isDefault = false,
  });

  String get displayName {
    switch (type) {
      case 'visa':
        return 'Visa •••• $lastFourDigits';
      case 'mastercard':
        return 'Mastercard •••• $lastFourDigits';
      case 'cash':
        return 'Cash on Delivery';
      default:
        return 'Card •••• $lastFourDigits';
    }
  }

  IconData get icon {
    switch (type) {
      case 'visa':
        return Icons.payment;
      case 'mastercard':
        return Icons.credit_card;
      case 'cash':
        return Icons.money;
      default:
        return Icons.credit_card;
    }
  }
} 