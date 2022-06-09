import '../services/messaging/messaging_service.dart';

class MessagingViewModel {
  static Stream loadNotifications() {
    return MessagingService.loadNotifications();
  }

  static NotificationInit() {
    MessagingService.NotificationInit();
    MessagingService.storeNotificationToken();
  }
}