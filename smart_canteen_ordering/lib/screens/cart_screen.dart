import 'package:flutter/material.dart';
import '../data/cart_store.dart';
import '../theme/app_theme.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _pickup = '12:30 PM – 12:45 PM';

  @override
  Widget build(BuildContext context) {
    final store = CartStore.instance;
    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        final entries = store.items.entries.toList();
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('YOUR ORDER', style: TextStyle(fontSize: 10,
              fontWeight: FontWeight.w800, letterSpacing: 1.3,
              color: AppTheme.orange)),
            const SizedBox(height: 5),
            Text('My Cart', style: Theme.of(context).textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.w800, color: AppTheme.ink)),
            const SizedBox(height: 16),
            if (entries.isEmpty)
              const Expanded(child: Center(child: Column(
                mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.shopping_bag_outlined, size: 62, color: Color(0xFFE5DED5)),
                  SizedBox(height: 12),
                  Text('Your cart is empty', style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w700, color: AppTheme.ink)),
                  SizedBox(height: 5),
                  Text('Add your favourite food from the Menu.',
                    style: TextStyle(color: AppTheme.muted, fontSize: 13)),
                ],
              )))
            else ...[
              Expanded(child: ListView.separated(
                itemCount: entries.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final item = CartStore.demoItem(entries[index].key)!;
                  final qty = entries[index].value;
                  return Card(child: Padding(padding: const EdgeInsets.all(10),
                    child: Row(children: [
                      ClipRRect(borderRadius: BorderRadius.circular(10),
                        child: Image.network(item.imageUrl, width: 64, height: 64,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const SizedBox(width: 64,
                            height: 64, child: Icon(Icons.restaurant)))),
                      const SizedBox(width: 11),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name, style: const TextStyle(
                            fontWeight: FontWeight.w700, color: AppTheme.ink)),
                          Text('₹${item.price.toStringAsFixed(0)} each',
                            style: const TextStyle(color: AppTheme.muted, fontSize: 12)),
                        ])),
                      IconButton(onPressed: () => store.remove(item),
                        icon: const Icon(Icons.remove_circle_outline)),
                      Text('$qty', style: const TextStyle(fontWeight: FontWeight.w700)),
                      IconButton(onPressed: () => store.add(item),
                        icon: const Icon(Icons.add_circle_outline, color: AppTheme.orange)),
                    ]),
                  ));
                },
              )),
              const SizedBox(height: 12),
              const Text('Choose pickup slot', style: TextStyle(
                fontWeight: FontWeight.w700, color: AppTheme.ink)),
              const SizedBox(height: 7),
              DropdownButtonFormField<String>(
                value: _pickup,
                decoration: const InputDecoration(),
                items: const [
                  DropdownMenuItem(value: '12:30 PM – 12:45 PM', child: Text('12:30 PM – 12:45 PM')),
                  DropdownMenuItem(value: '12:45 PM – 1:00 PM', child: Text('12:45 PM – 1:00 PM')),
                  DropdownMenuItem(value: '1:00 PM – 1:15 PM', child: Text('1:00 PM – 1:15 PM')),
                  DropdownMenuItem(value: '1:15 PM – 1:30 PM', child: Text('1:15 PM – 1:30 PM')),
                ],
                onChanged: (value) => setState(() => _pickup = value!),
              ),
              const SizedBox(height: 12),
              Row(children: [
                const Expanded(child: Text('Total amount',
                  style: TextStyle(fontWeight: FontWeight.w700, color: AppTheme.ink))),
                Text('₹${store.total.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800,
                    color: AppTheme.green)),
              ]),
              const SizedBox(height: 10),
              SizedBox(width: double.infinity, height: 50,
                child: FilledButton(
                  onPressed: () {
                    store.checkout(_pickup);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Order placed successfully! Check My Orders.')));
                  },
                  style: FilledButton.styleFrom(backgroundColor: AppTheme.orange),
                  child: const Text('Place order'),
                )),
            ],
          ]),
        );
      },
    );
  }
}
