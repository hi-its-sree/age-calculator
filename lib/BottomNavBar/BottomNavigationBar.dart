import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentzy/BottomNavBar/ProfilePages.dart';
import 'package:rentzy/BottomNavBar/RoadAssistance.dart';
import 'package:rentzy/HomePages/MainHome.dart';
import 'package:rentzy/HomePages/SearchPage.dart';
import 'package:rentzy/HomePages/favourites.dart';
import '../Database/FetchUserDetails.dart';
import '../OrderPages/OrderTabs.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 2;
  Map<String, dynamic>? userDetails;
  late List<Widget> pages;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Initialize with empty pages first
      pages = [
        const FavouritesPage(),
        const Searchpage(),
        const MainHome(),
        const OrdersTabs(),
        const Center(child: CircularProgressIndicator()), // Temporary loading for profile
      ];

      // Load user details
      userDetails = await FetchDetails().fetchUserDetails();

      // Update pages with loaded data
      pages = [
        const FavouritesPage(),
        const Searchpage(),
        const MainHome(),
        const OrdersTabs(),
        Profilepages(details: userDetails!),
      ];

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error initializing app: $e");
      setState(() {
        isLoading = false;
        // Fallback profile page with error message
        pages = [
          const FavouritesPage(),
          const Searchpage(),
          const MainHome(),
          const OrdersTabs(),
          const Center(child: Text('Failed to load profile')),
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2.0,
              blurRadius: 10.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              // Refresh profile when switching to it
              if (index == 4) {
                _refreshProfile();
              }
              setState(() => currentIndex = index);
            },
            items: _buildNavItems(),
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey.shade700,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
          ),
        ),
      ),
    );
  }

  Future<void> _refreshProfile() async {
    try {
      final updatedDetails = await FetchDetails().fetchUserDetails();
      setState(() {
        userDetails = updatedDetails;
        pages[4] = Profilepages(details: userDetails!);
      });
    } catch (e) {
      print("Error refreshing profile: $e");
    }
  }

  List<BottomNavigationBarItem> _buildNavItems() {
    return [
      _buildNavItem(Icons.favorite, "Favorites", 0),
      _buildNavItem(Icons.search_outlined, "Search", 1),
      _buildNavItem(Icons.home_filled, "Home", 2),
      _buildNavItem(FontAwesomeIcons.shoppingBag, "Bookings", 3),
      _buildNavItem(Icons.person, "Profile", 4),
    ];
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 40,
        width: 70,
        decoration: BoxDecoration(
          color: currentIndex == index
              ? Colors.black.withOpacity(0.1)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 24),
      ),
      label: label,
    );
  }
}