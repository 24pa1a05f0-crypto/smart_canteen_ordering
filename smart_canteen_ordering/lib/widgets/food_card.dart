import 'package:flutter/material.dart';
import '../data/cart_store.dart';
import '../models/menu_item.dart';
import '../theme/app_theme.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({required this.item, this.compact = false, super.key});
  final MenuItem item;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          flex: compact ? 4 : 3,
          child: Stack(fit: StackFit.expand, children: [
            Image.network(item.imageUrl, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppTheme.paleOrange,
                child: const Icon(Icons.restaurant_rounded,
                  size: 48, color: AppTheme.orange),
              ),
              loadingBuilder: (context, child, progress) => progress == null
                ? child : Container(color: AppTheme.paleOrange,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(strokeWidth: 2))),
            if (!item.isAvailable)
              Positioned(top: 8, left: 8, child: _tag('Sold out')),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(9),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, children: [
            Text(item.name, maxLines: 2, overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800,
                color: AppTheme.ink)),
            if (!compact) ...[
              const SizedBox(height: 4),
              Text(item.description, maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 10, color: AppTheme.muted)),
            ],
            const SizedBox(height: 6),
            Row(children: [
              Expanded(child: Text('₹${item.price.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800,
                  color: AppTheme.green))),
              const Icon(Icons.star_rounded, size: 15, color: Color(0xFFF2B544)),
              Text(item.rating.toStringAsFixed(1),
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
            ]),
            const SizedBox(height: 5),
            SizedBox(width: double.infinity, height: 34,
              child: FilledButton.icon(
                onPressed: item.isAvailable ? () {
                  CartStore.instance.add(item);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${item.name} added to cart'),
                    duration: const Duration(seconds: 1),
                  ));
                } : null,
                icon: const Icon(Icons.add_shopping_cart_rounded, size: 15),
                label: const Text('Add to cart', style: TextStyle(fontSize: 11)),
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.orange,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                ),
              )),
          ]),
        ),
      ]),
    );
  }

  Widget _tag(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(20)),
    child: Text(text, style: const TextStyle(fontSize: 10,
      fontWeight: FontWeight.w700, color: AppTheme.muted)),
  );
}
