import 'package:flutter/material.dart';
import '../models/order.dart';
import 'order_tracking_screen.dart';

class OrderConfirmationScreen extends StatefulWidget {
  final Order order;

  const OrderConfirmationScreen({
    super.key,
    required this.order,
  });

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  final List<Map<String, dynamic>> _trackingSteps = [
    {
      'status': OrderStatus.placed,
      'title': 'Order Placed',
      'subtitle': 'We have received your order',
      'icon': Icons.receipt_long,
    },
    {
      'status': OrderStatus.confirmed,
      'title': 'Order Confirmed',
      'subtitle': 'Restaurant has confirmed your order',
      'icon': Icons.check_circle,
    },
    {
      'status': OrderStatus.preparing,
      'title': 'Preparing',
      'subtitle': 'Your food is being prepared',
      'icon': Icons.restaurant,
    },
    {
      'status': OrderStatus.onTheWay,
      'title': 'On the Way',
      'subtitle': 'Your food is on the way',
      'icon': Icons.delivery_dining,
    },
    {
      'status': OrderStatus.delivered,
      'title': 'Delivered',
      'subtitle': 'Enjoy your meal!',
      'icon': Icons.done_all,
    },
  ];

  final String _estimatedTime = '30 minutes'; // Example default value

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showOrderConfirmation();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Status'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Order Status Card
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order id #${widget.order.id}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _getFormattedDate(widget.order.placedAt),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    _buildTrackingTimeline(),
                  ],
                ),
              ),
            ),

            // Restaurant Info
            _buildSection(
              title: 'Restaurant',
              content: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.restaurant,
                    color: Colors.deepOrange,
                  ),
                ),
                title: Text(widget.order.restaurantName),
                subtitle: const Text('Preparing your order'),
              ),
            ),

            // Delivery Address
            _buildSection(
              title: 'Delivery Address',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.order.address.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(widget.order.address.address),
                  Text(widget.order.address.details),
                ],
              ),
            ),

            // Order Summary
            _buildSection(
              title: 'Order Summary',
              content: Column(
                children: [
                  ...widget.order.items.map(
                    (item) => Padding(
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
                    ),
                  ),
                  const Divider(height: 24),
                  _buildSummaryRow('Subtotal', widget.order.subtotal),
                  _buildSummaryRow('Delivery Fee', widget.order.deliveryFee),
                  if (widget.order.discount > 0)
                    _buildSummaryRow('Discount', -widget.order.discount,
                        isDiscount: true),
                  const Divider(height: 24),
                  _buildSummaryRow('Total', widget.order.total, isTotal: true),
                ],
              ),
            ),

            // Support Section
            if (widget.order.status != OrderStatus.delivered)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    if (widget.order.status == OrderStatus.onTheWay &&
                        widget.order.driverPhone != null)
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.phone),
                        label: const Text('Call Driver'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 48),
                        ),
                      ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.support_agent),
                      label: const Text('Contact Support'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingTimeline() {
    return Column(
      children: List.generate(_trackingSteps.length, (index) {
        final step = _trackingSteps[index];
        final isCompleted = widget.order.status.index >= step['status'].index;
        final isActive = widget.order.status == step['status'];

        return Row(
          children: [
            Column(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color:
                        isCompleted ? Colors.deepOrange : Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    step['icon'],
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                if (index < _trackingSteps.length - 1)
                  Container(
                    width: 2,
                    height: 30,
                    color:
                        isCompleted ? Colors.deepOrange : Colors.grey.shade300,
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.normal,
                      color: isActive ? Colors.deepOrange : null,
                    ),
                  ),
                  Text(
                    step['subtitle'],
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget content,
  }) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    double amount, {
    bool isTotal = false,
    bool isDiscount = false,
  }) {
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

  String _getFormattedDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }

  void _showOrderConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Order Placed Successfully!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text('Estimated delivery time: $_estimatedTime'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      OrderTrackingScreen(order: widget.order),
                ),
              );
            },
            child: const Text('Track Order'),
          ),
        ],
      ),
    );
  }
}
