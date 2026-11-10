import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('ACCOUNT', style: TextStyle(fontSize: 10,
          fontWeight: FontWeight.w800, letterSpacing: 1.3, color: AppTheme.orange)),
        const SizedBox(height: 5),
        Text('My Profile', style: Theme.of(context).textTheme.headlineSmall
          ?.copyWith(fontWeight: FontWeight.w800, color: AppTheme.ink)),
        const SizedBox(height: 22),
        Card(child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
          const CircleAvatar(radius: 27, backgroundColor: AppTheme.paleOrange,
            child: Icon(Icons.person_rounded, color: AppTheme.orange, size: 29)),
          const SizedBox(width: 13),
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Student account', style: TextStyle(fontWeight: FontWeight.w700,
              fontSize: 15, color: AppTheme.ink)),
            SizedBox(height: 4),
            Text('Local demo profile', style: TextStyle(fontSize: 12, color: AppTheme.muted)),
          ]),
        ]))),
        const SizedBox(height: 18),
        _ProfileOption(icon: Icons.info_outline_rounded, title: 'About Smart Canteen',
          onTap: () => _show(context, 'About Smart Canteen',
            'Smart Canteen helps students browse food, add items to a cart, select a pickup slot and place a demo order.')),
        const SizedBox(height: 9),
        _ProfileOption(icon: Icons.help_outline_rounded, title: 'Help and support',
          onTap: () => _show(context, 'Help and support',
            'For this student demo, use Menu to add food, Cart to change quantities and place an order, and Orders to view order status.')),
        const SizedBox(height: 9),
        _ProfileOption(icon: Icons.privacy_tip_outlined, title: 'Privacy information',
          onTap: () => _show(context, 'Privacy information',
            'This version stores cart and order information only in memory on this device. It does not connect to a backend.')),
      ]),
    );
  }

  void _show(BuildContext context, String title, String message) {
    showDialog<void>(context: context, builder: (_) => AlertDialog(
      title: Text(title), content: Text(message),
      actions: [TextButton(onPressed: () => Navigator.pop(context),
        child: const Text('Close'))],
    ));
  }
}

class _ProfileOption extends StatelessWidget {
  const _ProfileOption({required this.icon, required this.title, required this.onTap});
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Card(child: ListTile(
    leading: Icon(icon, color: AppTheme.orange), title: Text(title,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600,
        color: AppTheme.ink)),
    trailing: const Icon(Icons.chevron_right_rounded, color: AppTheme.muted),
    onTap: onTap,
  ));
}
