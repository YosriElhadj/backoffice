import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';

class AdminScaffold extends StatefulWidget {
  final Widget child;
  final String title;

  const AdminScaffold({
    Key? key, 
    required this.child, 
    required this.title
  }) : super(key: key);

  @override
  _AdminScaffoldState createState() => _AdminScaffoldState();
}

class _AdminScaffoldState extends State<AdminScaffold> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _menuItems = [
    {
      'title': 'Dashboard', 
      'icon': Icons.dashboard, 
      'route': '/dashboard'
    },
    {
      'title': 'Properties', 
      'icon': Icons.real_estate_agent, 
      'route': '/properties'
    },
    {
      'title': 'Users', 
      'icon': Icons.people, 
      'route': '/users'
    },
    {
      'title': 'Analytics', 
      'icon': Icons.analytics, 
      'route': '/analytics'
    },
    {
      'title': 'Settings', 
      'icon': Icons.settings, 
      'route': '/settings'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Side Navigation
          Container(
            width: 250,
            color: AppColors.primary,
            child: Column(
              children: [
                // Logo and App Name
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'TheBoost Admin',
                    style: AppStyles.headline2.copyWith(color: Colors.white),
                  ),
                ),
                
                // Navigation Items
                Expanded(
                  child: ListView.builder(
                    itemCount: _menuItems.length,
                    itemBuilder: (context, index) {
                      return _buildNavItem(
                        _menuItems[index]['title'], 
                        _menuItems[index]['icon'], 
                        index
                      );
                    },
                  ),
                ),
                
                // Logout
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: Text(
                      'Logout', 
                      style: AppStyles.buttonText.copyWith(color: Colors.white),
                    ),
                    onPressed: () {
                      // TODO: Implement logout
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      minimumSize: const Size.fromHeight(50),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Top App Bar
                Container(
                  height: 70,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title, 
                        style: AppStyles.headline2,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.notifications),
                            onPressed: () {
                              // TODO: Implement notifications
                            },
                          ),
                          const SizedBox(width: 10),
                          CircleAvatar(
                            backgroundColor: AppColors.primary,
                            child: Text(
                              'AD', 
                              style: AppStyles.buttonText.copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Main Content
                Expanded(
                  child: widget.child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, IconData icon, int index) {
    final isSelected = _selectedIndex == index;
    return ListTile(
      selected: isSelected,
      selectedTileColor: Colors.white.withOpacity(0.2),
      leading: Icon(
        icon, 
        color: isSelected ? Colors.white : Colors.white70,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white70,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        // Navigate to the corresponding route
        Navigator.of(context).pushReplacementNamed(_menuItems[index]['route']);
      },
    );
  }
}