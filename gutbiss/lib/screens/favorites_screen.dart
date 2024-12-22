import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../screens/restaurant_details_screen.dart';
import '../screens/menu_item_details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample data (replace with actual data)
  final List<Map<String, dynamic>> _favoriteRestaurants = [
    {
      'name': 'Italian Restaurant',
      'rating': '4.5',
      'deliveryTime': '20-30 min',
      'deliveryFee': '\₹2.99',
      'cuisine': 'Italian',
      'image': Icons.restaurant,
    },
    {
      'name': 'Sushi Place',
      'rating': '4.8',
      'deliveryTime': '25-35 min',
      'deliveryFee': '\₹3.99',
      'cuisine': 'Japanese',
      'image': Icons.set_meal,
    },
  ];

  final List<MenuItem> _favoriteItems = [
    MenuItem(
      name: 'Margherita Pizza',
      description: 'Fresh tomatoes, mozzarella, basil, and olive oil',
      price: 12.99,
      image: 'pizza',
      category: 'Main Course',
    ),
    MenuItem(
      name: 'Caesar Salad',
      description: 'Romaine lettuce, croutons, parmesan cheese with Caesar dressing',
      price: 8.99,
      image: 'salad',
      category: 'Starters',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.deepOrange,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.deepOrange,
          tabs: const [
            Tab(text: 'Restaurants'),
            Tab(text: 'Menu Items'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Restaurants Tab
          _favoriteRestaurants.isEmpty
              ? _buildEmptyState('No favorite restaurants yet')
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _favoriteRestaurants.length,
                  itemBuilder: (context, index) {
                    return _buildRestaurantCard(_favoriteRestaurants[index]);
                  },
                ),

          // Menu Items Tab
          _favoriteItems.isEmpty
              ? _buildEmptyState('No favorite menu items yet')
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _favoriteItems.length,
                  itemBuilder: (context, index) {
                    return _buildMenuItemCard(_favoriteItems[index]);
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 100,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Items you favorite will appear here',
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantCard(Map<String, dynamic> restaurant) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RestaurantDetailsScreen(
                restaurantName: restaurant['name'],
                rating: restaurant['rating'],
                deliveryTime: restaurant['deliveryTime'],
                deliveryFee: restaurant['deliveryFee'],
                restaurantImg: '',

              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  restaurant['image'],
                  size: 40,
                  color: Colors.deepOrange,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      restaurant['cuisine'],
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(restaurant['rating']),
                        const SizedBox(width: 16),
                        const Icon(Icons.access_time,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(restaurant['deliveryTime']),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.favorite, color: Colors.deepOrange),
                onPressed: () {
                  setState(() {
                    _favoriteRestaurants.remove(restaurant);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItemCard(MenuItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MenuItemDetailsScreen(menuItem: item, imageUrl: 'assets/img/cat1.jpg',),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.restaurant,
                  size: 40,
                  color: Colors.deepOrange,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\₹${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.favorite, color: Colors.deepOrange),
                onPressed: () { 
                  setState(() {
                    _favoriteItems.remove(item);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
} 