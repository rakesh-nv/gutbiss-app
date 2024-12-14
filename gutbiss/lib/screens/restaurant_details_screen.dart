import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../models/review.dart';
import '../screens/menu_item_details_screen.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final String restaurantName;
  final String rating;
  final String deliveryTime;
  final String deliveryFee;
  final dynamic restaurantImg;

  const RestaurantDetailsScreen({
    super.key,
    required this.restaurantName,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.restaurantImg,
  });

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _categories = [
    'Starters',
    'Main Course',
    'Drinks',
    'Desserts'
  ];

  final List<MenuItem> _menuItems = [
    MenuItem(
      name: 'Caesar Salad',
      description:
          'Romaine lettuce, croutons, parmesan cheese with Caesar dressing',
      price: 8.99,
      image: 'salad',
      category: 'Starters',
    ),
    MenuItem(
      name: 'Caesar Salad',
      description:
          'Romaine lettuce, croutons, parmesan cheese with Caesar dressing',
      price: 8.99,
      image: 'salad',
      category: 'Starters',
    ),
    MenuItem(
      name: 'Caesar Salad',
      description:
          'Romaine lettuce, croutons, parmesan cheese with Caesar dressing',
      price: 8.99,
      image: 'salad',
      category: 'Starters',
    ),
    MenuItem(
      name: 'Caesar Salad',
      description:
          'Romaine lettuce, croutons, parmesan cheese with Caesar dressing',
      price: 8.99,
      image: 'salad',
      category: 'Starters',
    ),
    MenuItem(
      name: 'Caesar Salad',
      description:
          'Romaine lettuce, croutons, parmesan cheese with Caesar dressing',
      price: 8.99,
      image: 'salad',
      category: 'Starters',
    ),
    MenuItem(
      name: 'Caesar Salad',
      description:
          'Romaine lettuce, croutons, parmesan cheese with Caesar dressing',
      price: 8.99,
      image: 'salad',
      category: 'Starters',
    ),
    MenuItem(
      name: 'Margherita Pizza',
      description: 'Fresh tomatoes, mozzarella, basil, and olive oil',
      price: 12.99,
      image: 'pizza',
      category: 'Main Course',
    ),
    MenuItem(
      name: 'Margherita Pizza',
      description: 'Fresh tomatoes, mozzarella, basil, and olive oil',
      price: 12.99,
      image: 'pizza',
      category: 'Main Course',
    ),
    // Add more menu items...
  ];

  final List<Review> _reviews = [
    Review(
      userName: 'John Doe',
      rating: 4.5,
      comment: 'Great food and fast delivery! Will order again.',
      date: '2024-03-15',
    ),
    Review(
      userName: 'Jane Smith',
      rating: 5.0,
      comment: 'Best Italian food in town! Loved the pizza.',
      date: '2024-03-14',
    ),
    // Add more reviews...
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Restaurant Header
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: Image.asset(
                    widget.restaurantImg,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                title: Text(widget.restaurantName),
              ),
            ),

            // Restaurant Info
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(widget.rating),
                        const SizedBox(width: 16),
                        const Icon(Icons.access_time,
                            color: Colors.grey, size: 20),
                        const SizedBox(width: 4),
                        Text(widget.deliveryTime),
                        const SizedBox(width: 16),
                        Text(
                          widget.deliveryFee,
                          style: const TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'About',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Authentic Italian cuisine with a modern twist. We use only the freshest ingredients to create memorable dishes.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            //Menu Categories Tabs
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabs: _categories
                      .map((category) => Tab(text: category))
                      .toList(),
                  labelColor: Colors.deepOrange,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.deepOrange,
                ),
              ),
            ),

            // Menu Items
            SliverFillRemaining(
              fillOverscroll: true,
              child: TabBarView(
                controller: _tabController,
                children: _categories.map((category) {
                  final categoryItems = _menuItems
                      .where((item) => item.category == category)
                      .toList();

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: categoryItems.length,
                    itemBuilder: (context, index) {
                      final item = categoryItems[index];
                      return _buildMenuItem(item);
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildMenuItem(MenuItem item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuItemDetailsScreen(menuItem: item),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                // child: const Icon(
                //   Icons.restaurant,
                //   size: 40,
                //   color: Colors.deepOrange,
                // ),
                child: Container(
                  color: Colors.red,
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
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\₹${item.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Add to Cart'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(0, -2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                _showReviews();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('See Reviews'),
            ),
          ),
        ],
      ),
    );
  }

  void _showReviews() {
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
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _reviews.length,
                itemBuilder: (context, index) {
                  final review = _reviews[index];
                  return _buildReviewItem(review);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewItem(Review review) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.userName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(review.rating.toString()),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(review.comment),
            const SizedBox(height: 8),
            Text(
              review.date,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
