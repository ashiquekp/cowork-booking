import 'dart:async';
import '../../models/notification_item.dart';

class NotificationRepository {
  final _items = <NotificationItem>[];

  Future<List<NotificationItem>> fetch() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_items.reversed);
  }

  Future<void> push({required String title, required String body}) async {
    final item = NotificationItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      body: body,
      time: DateTime.now(),
    );
    _items.add(item);
  }
}
