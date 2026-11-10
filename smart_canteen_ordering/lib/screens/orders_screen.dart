import 'package:flutter/material.dart';
import '../data/cart_store.dart';
import '../theme/app_theme.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final store = CartStore.instance;
    return AnimatedBuilder(
      animation: store,
      builder: (context, _) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('YOUR ACTIVITY', style: TextStyle(fontSize: 10,
            fontWeight: FontWeight.w800, letterSpacing: 1.3, color: AppTheme.orange)),
          const SizedBox(height: 5),
          Text('My Orders', style: Theme.of(context).textTheme.headlineSmall
            ?.copyWith(fontWeight: FontWeight.w800, color: AppTheme.ink)),
          const SizedBox(height: 15),
          Expanded(child: store.orders.isEmpty
            ? const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.receipt_long_outlined, size: 56, color: Color(0xFFE5DED5)),
                SizedBox(height: 14),
                Text('No orders yet', style: TextStyle(fontSize: 17,
                  fontWeight: FontWeight.w700, color: AppTheme.ink)),
                SizedBox(height: 6),
                Text('Your canteen orders will show up here.',
                  style: TextStyle(fontSize: 13, color: AppTheme.muted)),
              ]))
            : ListView.separated(
                itemCount: store.orders.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final order = store.orders[index];
                  final itemCount = (order['items'] as Map<String, int>)
                    .values.fold<int>(0, (a, b) => a + b);
                  return Card(child: ListTile(
                    leading: const CircleAvatar(backgroundColor: AppTheme.paleOrange,
                      child: Icon(Icons.receipt_long, color: AppTheme.orange)),
                    title: Text('Order #${order['id']}',
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text('$itemCount item(s) • Pickup ${order['pickup']}\n${order['status']}'),
                    isThreeLine: true,
                    trailing: Text('₹${(order['total'] as double).toStringAsFixed(0)}',
                      style: const TextStyle(fontWeight: FontWeight.w800,
                        color: AppTheme.green)),
                  ));
                },
              )),
        ]),
      ),
    );
  }
}
