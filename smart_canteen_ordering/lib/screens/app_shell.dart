import 'package:flutter/material.dart';
import '../data/cart_store.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'menu_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';
import 'cart_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;
  String _menuQuery = '';
  String _menuCategory = 'All';

  void _openMenu({String? query, String? category}) {
    setState(() {
      _selectedIndex = 1;
      _menuQuery = query ?? '';
      _menuCategory = category ?? 'All';
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(onOpenMenu: _openMenu),
      MenuScreen(initialQuery: _menuQuery, initialCategory: _menuCategory),
      const CartScreen(),
      const OrdersScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: SafeArea(bottom: false,
        child: IndexedStack(index: _selectedIndex, children: pages)),
      bottomNavigationBar: AnimatedBuilder(
        animation: CartStore.instance,
        builder: (context, _) => NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) => setState(() => _selectedIndex = index),
          destinations: [
            const NavigationDestination(icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded), label: 'Home'),
            const NavigationDestination(icon: Icon(Icons.restaurant_menu_rounded),
              selectedIcon: Icon(Icons.restaurant_menu_rounded), label: 'Menu'),
            NavigationDestination(
              icon: Badge(label: Text('${CartStore.instance.itemCount}'),
                isLabelVisible: CartStore.instance.itemCount > 0,
                child: const Icon(Icons.shopping_cart_outlined)),
              selectedIcon: const Icon(Icons.shopping_cart_rounded), label: 'Cart'),
            const NavigationDestination(icon: Icon(Icons.receipt_long_outlined),
              selectedIcon: Icon(Icons.receipt_long_rounded), label: 'Orders'),
            const NavigationDestination(icon: Icon(Icons.person_outline_rounded),
              selectedIcon: Icon(Icons.person_rounded), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
