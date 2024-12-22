import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../models/menu_item_option.dart';
import '../screens/cart_screen.dart';

class MenuItemDetailsScreen extends StatefulWidget {
  final MenuItem menuItem;
  final String imageUrl;

  const MenuItemDetailsScreen({
    super.key,
    required this.menuItem,
    required this.imageUrl,
  });

  @override
  State<MenuItemDetailsScreen> createState() => _MenuItemDetailsScreenState();
}

class _MenuItemDetailsScreenState extends State<MenuItemDetailsScreen> {
  int _quantity = 1;
  double _totalPrice = 0;
  final List<MenuItemOption> _customizationOptions = [
    MenuItemOption(
      name: 'Size',
      price: 0,
      isRequired: true,
      choices: [
        MenuItemOptionChoice(name: 'Regular', isSelected: true),
        MenuItemOptionChoice(name: 'Large', additionalPrice: 2.00),
        MenuItemOptionChoice(name: 'Extra Large', additionalPrice: 4.00),
      ],
    ),
    MenuItemOption(
      name: 'Extra Toppings',
      price: 1.50,
      allowMultiple: true,
      choices: [
        MenuItemOptionChoice(name: 'Cheese'),
        MenuItemOptionChoice(name: 'Mushrooms'),
        MenuItemOptionChoice(name: 'Olives'),
        MenuItemOptionChoice(name: 'Onions'),
      ],
    ),
    MenuItemOption(
      name: 'Special Instructions',
      price: 0,
      choices: [
        MenuItemOptionChoice(name: 'Extra Spicy'),
        MenuItemOptionChoice(name: 'No Garlic'),
        MenuItemOptionChoice(name: 'Well Done'),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    double basePrice = widget.menuItem.price;
    double optionsPrice = 0;

    for (var option in _customizationOptions) {
      for (var choice in option.choices) {
        if (choice.isSelected) {
          optionsPrice += choice.additionalPrice;
          if (!option.allowMultiple) break;
        }
      }
    }

    setState(() {
      _totalPrice = (basePrice + optionsPrice) * _quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Item Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.grey.shade200,
                child:Image.asset(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),

          // Item Details
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Description
                  Text(
                    widget.menuItem.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.menuItem.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Quantity Selector
                  Row(
                    children: [
                      const Text(
                        'Quantity',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (_quantity > 1) {
                                  setState(() {
                                    _quantity--;
                                    _calculateTotalPrice();
                                  });
                                }
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text(
                              _quantity.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _quantity++;
                                  _calculateTotalPrice();
                                });
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Customization Options
                  const Text(
                    'Customize Your Order',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Options List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final option = _customizationOptions[index];
                return _buildOptionSection(option);
              },
              childCount: _customizationOptions.length,
            ),
          ),

          // Bottom Padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildOptionSection(MenuItemOption option) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                option.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (option.isRequired)
                Text(
                  ' (Required)',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: option.choices.map((choice) {
              return FilterChip(
                selected: choice.isSelected,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(choice.name),
                    if (choice.additionalPrice > 0)
                      Text(
                        ' (+\₹${choice.additionalPrice.toStringAsFixed(2)})',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.deepOrange,
                        ),
                      ),
                  ],
                ),
                onSelected: (selected) {
                  setState(() {
                    if (option.allowMultiple) {
                      choice.isSelected = selected;
                    } else {
                      for (var c in option.choices) {
                        c.isSelected = c == choice ? selected : false;
                      }
                    }
                    _calculateTotalPrice();
                  });
                },
                //selectedColor: Colors.deepOrange.shade100,
                checkmarkColor: Colors.deepOrange,
              );
            }).toList(),
          ),
          const Divider(height: 32),
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
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Price',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Text(
                '\₹${_totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}
