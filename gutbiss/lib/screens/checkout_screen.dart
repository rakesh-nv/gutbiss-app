import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/delivery_address.dart';
import '../models/payment_method.dart';
import '../models/order.dart';
import '../screens/order_confirmation_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final double subtotal;
  final double deliveryFee;
  final double discount;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  DeliveryAddress? _selectedAddress;
  PaymentMethod? _selectedPayment;
  final String _estimatedTime = '30-45 min';

  // Sample data (replace with actual data from your backend)
  final List<DeliveryAddress> _addresses = [
    DeliveryAddress(
      id: '1',
      name: 'Home',
      address: '123 Main Street',
      details: 'Apt 4B',
      isDefault: true,
    ),
    DeliveryAddress(
      id: '2',
      name: 'Work',
      address: '456 Office Road',
      details: 'Floor 12',
    ),
  ];

  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(
      id: '1',
      type: 'visa',
      lastFourDigits: '4242',
      expiryDate: '12/24',
      isDefault: true,
    ),
    PaymentMethod(
      id: '2',
      type: 'mastercard',
      lastFourDigits: '8888',
      expiryDate: '10/25',
    ),
    PaymentMethod(
      id: '3',
      type: 'cash',
      lastFourDigits: '',
      expiryDate: '',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedAddress = _addresses.firstWhere((addr) => addr.isDefault);
    _selectedPayment = _paymentMethods.firstWhere((pay) => pay.isDefault);
  }

  void _showAddressSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Delivery Address',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add New'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: _addresses.length,
                itemBuilder: (context, index) {
                  final address = _addresses[index];
                  return RadioListTile<DeliveryAddress>(
                    value: address,
                    groupValue: _selectedAddress,
                    onChanged: (value) {
                      setState(() {
                        _selectedAddress = value;
                      });
                      Navigator.pop(context);
                    },
                    title: Text(address.name),
                    subtitle: Text(
                      '${address.address}\n${address.details}',
                    ),
                    secondary: address.isDefault
                        ? const Chip(
                            label: Text('Default'),
                            backgroundColor: Colors.deepOrange,
                            labelStyle: TextStyle(color: Colors.white),
                          )
                        : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Payment Method',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                 
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add New'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _paymentMethods.length,
              itemBuilder: (context, index) {
                final payment = _paymentMethods[index];
                return RadioListTile<PaymentMethod>(
                  value: payment,
                  groupValue: _selectedPayment,
                  onChanged: (value) {
                    setState(() {
                      _selectedPayment = value;
                    });
                    Navigator.pop(context);
                  },
                  title: Text(payment.displayName),
                  secondary: Icon(payment.icon),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Delivery Address
            _buildSection(
              title: 'Delivery Address',
              content: _selectedAddress != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedAddress!.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _selectedAddress!.address,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          _selectedAddress!.details,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    )
                  : const Text('Select delivery address'),
              onTap: _showAddressSelector,
            ),

            // Payment Method
            _buildSection(
              title: 'Payment Method',
              content: _selectedPayment != null
                  ? Row(
                      children: [
                        Icon(_selectedPayment!.icon),
                        const SizedBox(width: 8),
                        Text(
                          _selectedPayment!.displayName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : const Text('Select payment method'),
              onTap: _showPaymentSelector,
            ),

            // Order Summary
            _buildSection(
              title: 'Order Summary',
              content: Column(
                children: [
                  ...widget.cartItems.map((item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${item.quantity}x ${item.name}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              '\₹${item.totalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      )),
                  const Divider(),
                  _buildSummaryRow('Subtotal', widget.subtotal),
                  _buildSummaryRow('Delivery Fee', widget.deliveryFee),
                  if (widget.discount > 0)
                    _buildSummaryRow('Discount', -widget.discount,
                        isDiscount: true),
                  const Divider(),
                  _buildSummaryRow(
                    'Total',
                    widget.subtotal + widget.deliveryFee - widget.discount,
                    isTotal: true,
                  ),
                ],
              ),
            ),

            // Estimated Time
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.deepOrange),
                  const SizedBox(width: 8),
                  Text(
                    'Estimated Delivery Time: $_estimatedTime',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget content,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (onTap != null)
                  const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
            const SizedBox(height: 8),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount,
      {bool isTotal = false, bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            isDiscount
                ? '-\₹${amount.toStringAsFixed(2)}'
                : '\₹${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isDiscount ? Colors.green : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
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
      child: ElevatedButton(
        onPressed: () {
        
          _showOrderConfirmation();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          'Place Order',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  void _showOrderConfirmation() {
    final order = Order(
      id: 'ORD${DateTime.now().millisecondsSinceEpoch}',
      restaurantName: widget.cartItems.first.restaurantName,
      items: widget.cartItems,
      address: _selectedAddress!,
      subtotal: widget.subtotal,
      deliveryFee: widget.deliveryFee,
      discount: widget.discount,
      status: OrderStatus.placed,
      placedAt: DateTime.now(),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OrderConfirmationScreen(order: order),
      ),
    );
  }
} 