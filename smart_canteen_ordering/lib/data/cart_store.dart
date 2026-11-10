import 'package:flutter/foundation.dart';
import '../models/menu_item.dart';
import 'demo_menu.dart';

class CartStore extends ChangeNotifier {
  CartStore._();
  static final CartStore instance = CartStore._();

  final Map<String, int> _items = {};
  final List<Map<String, dynamic>> _orders = [];

  Map<String, int> get items => Map.unmodifiable(_items);
  List<Map<String, dynamic>> get orders => List.unmodifiable(_orders);
  int get itemCount => _items.values.fold(0, (a, b) => a + b);
  double get total => _items.entries.fold(0, (sum, entry) {
    final item = demoItem(entry.key);
    return sum + (item?.price ?? 0) * entry.value;
  });

  void add(MenuItem item) {
    _items.update(item.id, (value) => value + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void remove(MenuItem item) {
    final count = _items[item.id] ?? 0;
    if (count <= 1) {
      _items.remove(item.id);
    } else {
      _items[item.id] = count - 1;
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  void checkout(String pickupSlot) {
    if (_items.isEmpty) return;
    _orders.insert(0, {
      'id': 'SC${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      'items': Map<String, int>.from(_items),
      'total': total,
      'pickup': pickupSlot,
      'status': 'Confirmed',
      'created': DateTime.now(),
    });
    _items.clear();
    notifyListeners();
  }

  static MenuItem? demoItem(String id) {
    for (final item in demoMenu) {
      if (item.id == id) return item;
    }
    return null;
  }
}
