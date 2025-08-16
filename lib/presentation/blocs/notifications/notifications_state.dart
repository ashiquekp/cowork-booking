import 'package:equatable/equatable.dart';

import '../../../models/notification_item.dart';

class NotificationsState extends Equatable {
  final bool loading;
  final String? error;
  final List<NotificationItem> items;

  const NotificationsState._({
    required this.loading,
    this.error,
    required this.items,
  });

  const NotificationsState.loading() : this._(loading: true, items: const []);
  const NotificationsState.error(String message)
    : this._(loading: false, error: message, items: const []);
  const NotificationsState.loaded(List<NotificationItem> items)
    : this._(loading: false, items: items);

  @override
  List<Object?> get props => [loading, error, items];
}
