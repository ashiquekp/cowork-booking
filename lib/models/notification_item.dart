import 'package:equatable/equatable.dart';

class NotificationItem extends Equatable {
  final String id;
  final String title;
  final String body;
  final DateTime time;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
  });

  @override
  List<Object?> get props => [id, title, body, time];
}
