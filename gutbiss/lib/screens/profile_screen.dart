import 'package:flutter/material.dart';
import 'package:gutbiss/screens/settings_screen.dart';
import '../models/user_profile.dart';
import '../models/delivery_address.dart';
import '../models/payment_method.dart';
import '../models/order.dart';
import '../screens/order_history_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Sample user data (replace with actual user data)
  final UserProfile _user = UserProfile(
    id: '1',
    name: 'N V RAKESH',
    email: 'rakesh123@gmail.con',
    phoneNumber: '+1 234 567 8900',
    notificationsEnabled: true,
  );

  final List<Order> _recentOrders = []; // Add sample orders here
  final List<DeliveryAddress> _savedAddresses = []; // Add sample addresses here
  final List<PaymentMethod> _paymentMethods =
      []; // Add sample payment methods here

  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: _user.profilePicture != null
                            ? NetworkImage(_user.profilePicture!)
                            : null,
                        child: _user.profilePicture == null
                            ? const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.deepOrange,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _user.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _user.email,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

            // Profile Options
            _buildSection(
              title: 'Orders',
              icon: Icons.receipt_long,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderHistoryScreen(),
                  ),
                );
              },
              trailing: const Text('View History'),
            ),

            _buildSection(
              title: 'Addresses',
              icon: Icons.location_on,
              onTap: () {},
              trailing: Text('${_savedAddresses.length} Saved'),
            ),

            _buildSection(
              title: 'Payment Methods',
              icon: Icons.payment,
              onTap: () {},
              trailing: Text('${_paymentMethods.length} Saved'),
            ),

            _buildSection(
              title: 'Recent Orders',
              icon: Icons.receipt,
              onTap: () {},
              trailing: Text('${_recentOrders.length} Recent'),
            ),

            const Divider(),

            // Settings
            _buildSection(
              title: 'Settings',
              icon: Icons.settings,
              onTap: () {
                //_showLanguageSelector();
                // _showNotificationToggle();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => settings(),
                  ),
                );
              },
            ),

            const Divider(),

            // Logout Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  _showLogoutConfirmation();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepOrange),
      title: Text(title),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  // void _showLanguageSelector() {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (context) => Container(
  //       padding: const EdgeInsets.symmetric(vertical: 20),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           const Padding(
  //             padding: EdgeInsets.all(16),
  //             child: Text(
  //               'Select Language',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //           ...List.generate(
  //             _availableLanguages.length,
  //             (index) => RadioListTile<String>(
  //               value: _availableLanguages[index],
  //               groupValue: _selectedLanguage,
  //               onChanged: (value) {
  //                 setState(() {
  //                   _selectedLanguage = value!;
  //                 });
  //                 Navigator.pop(context);
  //               },
  //               title: Text(_availableLanguages[index]),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showNotificationToggle() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notifications'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Enable Notifications'),
            Switch(
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
