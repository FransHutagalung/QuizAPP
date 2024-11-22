import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

class FirebaseNotifications {
  final _logger = Logger();
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    _logger.d('Token: $fcmToken');
    
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
    FirebaseMessaging.onMessage.listen(_onMessageReceived);  // Menangani pesan saat aplikasi aktif
    FirebaseMessaging.onMessageOpenedApp.listen(_onOpenedApp);
    
    _subscribeToTopic();
  }

  // Fungsi untuk menangani pesan saat aplikasi dalam background
  Future<void> _onBackgroundMessage(RemoteMessage message) async {
    _logger.d('onBackgroundMessage');
    _logger.d('Title: ${message.notification?.title}');
    _logger.d('Body: ${message.notification?.body}');
    _logger.d('Data: ${message.data}');
  }

  // Menangani pesan saat aplikasi aktif
  Future<void> _onMessageReceived(RemoteMessage message) async {
    _logger.d('onMessageReceived');
    _logger.d('Title: ${message.notification?.title}');
    _logger.d('Body: ${message.notification?.body}');
    _logger.d('Data: ${message.data}');
  }

  // Menangani saat notifikasi dibuka oleh pengguna
  Future<void> _onOpenedApp(RemoteMessage message) async {
    _logger.d('onOpenedApp');
    _logger.d('Title: ${message.notification?.title}');
    _logger.d('Body: ${message.notification?.body}');
    _logger.d('Data: ${message.data}');
  }

  // Subscribe ke topik
  Future<void> _subscribeToTopic() async {
    try {
      await _firebaseMessaging.subscribeToTopic('all_users');
      _logger.d('Subscribed to all_users');
    } catch (e) {
      _logger.e('Failed to subscribe to topic: $e');
    }
  }
}
