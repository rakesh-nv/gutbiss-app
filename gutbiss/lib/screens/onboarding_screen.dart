import 'package:flutter/material.dart';
import 'package:gutbiss/screens/login_screen.dart';
import '../models/onboarding_content.dart';
//import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      title: 'Find Your Favorite Food',
      description: 'Discover the best foods from over 1,000 restaurants',
      image: 'restaurant_menu',
    ),
    OnboardingContent(
      title: 'Fast Delivery',
      description: 'Fast delivery to your home, office, or wherever you are',
      image: 'delivery_dining',
    ),
    OnboardingContent(
      title: 'Live Tracking',
      description: 'Real-time tracking of your food on the app',
      image: 'location_on',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // void _navigateToHome() {
  //   Navigator.of(context).pushAndRemoveUntil(
  //     MaterialPageRoute(builder: (_) => const HomeScreen()),
  //     (route) => false,
  //   );
  // }

  void _navigateToLogin() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _navigateToLogin,
                  child: const Text('Skip'),
                ),
              ),

              // Page view
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _contents.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon instead of image
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.deepOrange.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _getIconData(_contents[index].image),
                              size: 100,
                              color: Colors.deepOrange,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Title
                          Text(
                            _contents[index].title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Description
                          Text(
                            _contents[index].description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Indicators and buttons
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    // Page indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _contents.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 30 : 10,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: _currentPage == index
                                ? Colors.deepOrange
                                // ignore: deprecated_member_use
                                : Colors.deepOrange.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Navigation buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back button
                        if (_currentPage > 0)
                          TextButton(
                            onPressed: () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: const Text('Back'),
                          )
                        else
                          const SizedBox(width: 80),

                        // Next/Get Started button
                        ElevatedButton(
                          onPressed: () {
                            if (_currentPage == _contents.length - 1) {
                              _navigateToLogin();
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                          ),
                          child: Text(
                            _currentPage == _contents.length - 1
                                ? 'Get Started'
                                : 'Next',
                          ),
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

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'restaurant_menu':
        return Icons.restaurant_menu;
      case 'delivery_dining':
        return Icons.delivery_dining;
      case 'location_on':
        return Icons.location_on;
      default:
        return Icons.error;
    }
  }
}
