import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../screens/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _promoController = TextEditingController();

  // Sample cart items (replace with actual cart data)
  final List<CartItem> _cartItems = [
    CartItem(
      id: '1',
      name: 'Margherita Pizza',
      price: 12.99,
      quantity: 2,
      customizations: ['Large', 'Extra Cheese'],
      restaurantName: 'Italian Restaurant',
    ),
    CartItem(
      id: '2',
      name: 'Caesar Salad',
      price: 8.99,
      quantity: 1,
      customizations: ['No Croutons'],
      restaurantName: 'Italian Restaurant',
    ),
  ];

  final double _deliveryFee = 2.99;
  String? _appliedPromoCode;
  double _promoDiscount = 0.0;

  double get _subtotal => _cartItems.fold(
        0,
        (sum, item) => sum + item.totalPrice,
      );

  double get _total => _subtotal + _deliveryFee - _promoDiscount;

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  void _removeItem(CartItem item) {
    setState(() {
      _cartItems.removeWhere((cartItem) => cartItem.id == item.id);
    });
  }

  void _updateQuantity(CartItem item, int newQuantity) {
    if (newQuantity < 1) return;

    setState(() {
      final index = _cartItems.indexWhere((cartItem) => cartItem.id == item.id);
      if (index != -1) {
        _cartItems[index] = CartItem(
          id: item.id,
          name: item.name,
          price: item.price,
          quantity: newQuantity,
          customizations: item.customizations,
          restaurantName: item.restaurantName,
        );
      }
    });
  }

  void _applyPromoCode() {
    // Simple promo code logic (replace with actual implementation)
    if (_promoController.text.toUpperCase() == 'SAVE10') {
      setState(() {
        _appliedPromoCode = 'SAVE10';
        _promoDiscount = _subtotal * 0.1; // 10% discount
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Promo code applied successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid promo code'),
          backgroundColor: Colors.red,
        ),
      );
    }
    _promoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: _cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                // Cart Items List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      return _buildCartItem(_cartItems[index]);
                    },
                  ),
                ),

                // Promo Code Input
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _promoController,
                          decoration: InputDecoration(
                            hintText: 'Enter promo code',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _applyPromoCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 24,
                          ),
                        ),
                        child: const Text('Apply'),
                      ),
                    ],
                  ),
                ),

                // Order Summary
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.shade200,
                    //     offset: const Offset(0, -2),
                    //     blurRadius: 6,
                    //   ),
                    // ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSummaryRow('Subtotal', _subtotal),
                      if (_promoDiscount > 0) ...[
                        const SizedBox(height: 8),
                        _buildSummaryRow(
                          'Discount ($_appliedPromoCode)',
                          -_promoDiscount,
                          isDiscount: true,
                        ),
                      ],
                      const SizedBox(height: 8),
                      _buildSummaryRow('Delivery Fee', _deliveryFee),
                      const Divider(height: 24),
                      _buildSummaryRow('Total', _total, isTotal: true),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutScreen(
                                cartItems: _cartItems,
                                subtotal: _subtotal,
                                deliveryFee: _deliveryFee,
                                discount: _promoDiscount,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Proceed to Checkout',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add items to start a new order',
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
            ),
            child: const Text('Browse Restaurants'),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.restaurantName,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      if (item.customizations.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          item.customizations.join(', '),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _removeItem(item),
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () =>
                            _updateQuantity(item, item.quantity - 1),
                        icon: const Icon(Icons.remove),
                        iconSize: 20,
                      ),
                      Text(
                        item.quantity.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            _updateQuantity(item, item.quantity + 1),
                        icon: const Icon(Icons.add),
                        iconSize: 20,
                      ),
                    ],
                  ),
                ),
                Text(
                  '\₹${item.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount,
      {bool isTotal = false, bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            //color: isTotal ? Colors.black : Colors.grey.shade600,
          ),
        ),
        Text(
          isDiscount
              ? '-\₹${amount.toStringAsFixed(2)}'
              : '\₹${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            // color: isDiscount
            //     ? Colors.green
            //     : (isTotal ? Colors.black : Colors.grey.shade600),
          ),
        ),
      ],
    );
  }
}
