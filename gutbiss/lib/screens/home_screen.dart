import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'orders_screen.dart';
import 'restaurant_details_screen.dart';
import 'profile_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    final List<Widget> screens = [
      // Home content
      _buildHomeContent(),
      const ordersScreen(),
      const FavoritesScreen(), // Add Favorites screen
    ];

    return Scaffold(
      body: SafeArea(
        child: screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return CustomScrollView(
      slivers: [
        // App Bar with Search
        SliverAppBar(
          floating: true,
          title: Container(
            padding: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              //color: Colors.grey.shade100,
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(

              controller: _searchController,
              decoration: const InputDecoration(

                hintText: 'Search for restaurants or dishes',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {},
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                child: const CircleAvatar(
                  child: Icon(Icons.person_outlined),
                ),
              ),
            ),
          ],
        ),

        // Promotional Banner
        SliverToBoxAdapter(
          child: SizedBox(
            height: 200,
            child: PageView(
              children: [
                _buildPromoBanner(
                  'Special Offer',
                  'Get 20% off on your first order!',
                  Colors.deepOrange,
                  Icons.local_offer,
                ),
                _buildPromoBanner(
                  'Free Delivery',
                  'On orders above \₹20',
                  Colors.green,
                  Icons.delivery_dining,
                ),
                _buildPromoBanner(
                  'Fast Food',
                  'Quick delivery under 30 minutes',
                  Colors.blue,
                  Icons.timer,
                ),
              ],
            ),
          ),
        ),

        // Categories
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                    height: 165,
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2.5,
                      ),
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildCategoryItem('Biryani', 'assets/img/cat1.jpg'),
                        _buildCategoryItem('Pizza', 'assets/img/cat2.jpg'),
                        _buildCategoryItem('Burger', 'assets/img/cat3.jpg'),
                        _buildCategoryItem('Samosa', 'assets/img/cat4.jpg'),
                        _buildCategoryItem('Chinese', 'assets/img/cat5.jpg'),
                        _buildCategoryItem('Cake', 'assets/img/cat6.jpg'),
                        _buildCategoryItem('South Indian', 'assets/img/cat7.jpg'),
                        _buildCategoryItem('Sandwich', 'assets/img/cat8.jpg'),
                        _buildCategoryItem('Biryani', 'assets/img/cat1.jpg'),
                        _buildCategoryItem('Pizza', 'assets/img/cat2.jpg'),
                        _buildCategoryItem('Burger', 'assets/img/cat3.jpg'),
                        _buildCategoryItem('Samosa', 'assets/img/cat4.jpg'),
                        _buildCategoryItem('Chinese', 'assets/img/cat5.jpg'),
                        _buildCategoryItem('Cake', 'assets/img/cat6.jpg'),
                        _buildCategoryItem('South Indian', 'assets/img/cat7.jpg'),
                        _buildCategoryItem('Sandwich', 'assets/img/cat8.jpg'),
                      ],
                    )
                    // ListView(
                    //   scrollDirection: Axis.horizontal,
                    //   children: [
                    //     _buildCategoryItem('All', Icons.restaurant, Colors.deepOrange),
                    //     _buildCategoryItem('Pizza', Icons.local_pizza, Colors.red),
                    //     _buildCategoryItem('Burger', Icons.lunch_dining, Colors.amber),
                    //     _buildCategoryItem('Sushi', Icons.set_meal, Colors.blue),
                    //     _buildCategoryItem('Dessert', Icons.cake, Colors.pink),
                    //     _buildCategoryItem('Drinks', Icons.local_bar, Colors.purple),
                    //   ],
                    // ),
                    ),
              ],
            ),
          ),
        ),

        // Popular Restaurants
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Popular Restaurants',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('See All'),
                ),
              ],
            ),
          ),
        ),

        // Restaurant List
        SliverList(
          delegate: SliverChildListDelegate([
            _buildRestaurantItem(
              'Italian Restaurant',
              '4.5',
              '20-30 min',
              '\₹299',
              'Italian cuisine • Pizza • Pasta',
              'assets/img/rest1.jpg',
            ),
            _buildRestaurantItem(
              'Sushi Place',
              '4.8',
              '25-35 min',
              '\₹399',
              'Japanese • Sushi • Asian',
              'assets/img/rest2.jpg',
            ),
            _buildRestaurantItem(
              'Burger Joint',
              '4.2',
              '15-25 min',
              '\₹199',
              'American • Burgers • Fast Food',
              'assets/img/rest3.jpg',
            ),
            _buildRestaurantItem(
              'Italian Restaurant',
              '4.5',
              '20-30 min',
              '\₹299',
              'Italian cuisine • Pizza • Pasta',
              'assets/img/rest1.jpg',
            ),
            _buildRestaurantItem(
              'Sushi Place',
              '4.8',
              '25-35 min',
              '\₹399',
              'Japanese • Sushi • Asian',
              'assets/img/rest2.jpg',
            ),
            _buildRestaurantItem(
              'Burger Joint',
              '4.2',
              '15-25 min',
              '\₹199',
              'American • Burgers • Fast Food',
              'assets/img/rest3.jpg',
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildPromoBanner(
      String title, String subtitle, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        // ignore: deprecated_member_use
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 16,
                    // ignore: deprecated_member_use
                    color: color.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            icon,
            size: 80,
            // ignore: deprecated_member_use
            color: color.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(
    String title,
    String imageUrl,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 65,
            height: 65,
            child: InkWell(
              onTap: () {
                print('hello');
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantItem(
    String name,
    String rating,
    String deliveryTime,
    String deliveryFee,
    String description,
    String imageUrl,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetailsScreen(
              restaurantName: name,
              rating: rating,
              deliveryTime: deliveryTime,
              deliveryFee: deliveryFee,
              restaurantImg: imageUrl,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant Image
            Container(
              height: 150,
              // decoration: BoxDecoration(
              //  color: Colors.grey.shade100,
              //   borderRadius: const BorderRadius.vertical(
              //     top: Radius.circular(20),
              //   ),
              // ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              rating,
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        deliveryTime,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.delivery_dining,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      // const SizedBox(width: 25),
                      // Text(
                      //   deliveryFee,
                      //   style: const TextStyle(
                      //     color: Colors.deepOrange,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
