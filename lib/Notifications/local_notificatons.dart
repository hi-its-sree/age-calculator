import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  final notificationPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // Initialization
  Future<void> initNotification() async {
    if (_isInitialized) return;

    // Android init settings
    const initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher'); // Changed to default launcher icon

    // Initialization settings
    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      // iOS: DarwinInitializationSettings(), // Add if you need iOS support
    );

    await notificationPlugin.initialize(
      initSettings,
      // onDidReceiveNotificationResponse: (details) { } // Add if you need notification tap handling
    );

    _isInitialized = true; // Mark as initialized
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily channel id',
        'daily notifications',
        channelDescription: 'Daily notification channel',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true, // Added sound
        enableVibration: true, // Added vibration
      ),
    );
  }

  // Show notification
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    if (!_isInitialized) {
      await initNotification();
    }

    return notificationPlugin.show(
        id,
        title,
        body,
        notificationDetails() // Fixed: Using the proper details method
    );
  }
}