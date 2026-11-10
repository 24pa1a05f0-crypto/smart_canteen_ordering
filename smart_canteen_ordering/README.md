# Smart Canteen – Flutter Project

A mobile-first college canteen ordering application built with Flutter and Material 3.

## Features
- Home screen with food categories and popular dishes
- Food menu with search and category filters
- Food photographs with graceful fallback placeholders
- Add items to cart and increase/decrease quantities
- Pickup-slot selection and demo checkout
- Order confirmation and order history
- Profile help, about and privacy information
- Bottom navigation with a live cart item badge

## Run locally
1. Install the Flutter SDK and Android Studio.
2. Extract this ZIP file.
3. Open the extracted `smart_canteen_repaired` folder in Android Studio or VS Code.
4. Run `flutter pub get`.
5. Connect an Android phone with USB debugging enabled, or start an Android emulator.
6. Run `flutter run`.

To create an APK:
```bash
flutter build apk --release
```
The APK will be created at `build/app/outputs/flutter-apk/app-release.apk`.

## Important project scope
This is a complete **working front-end demonstration**. Cart contents and placed orders are held in app memory and reset when the app process is closed. Checkout is a simulated canteen order; there is no real payment gateway, admin backend, authentication, Firebase database, or live order tracking yet. Food photos load from Unsplash and therefore require an internet connection.

## Useful folders
- `lib/screens/` – app screens
- `lib/widgets/` – reusable UI components
- `lib/data/` – sample menu and cart/order state
- `lib/models/` – food item model
- `lib/theme/` – app theme
- `android/` and `ios/` – platform projects
