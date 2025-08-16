import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/widgets/loading_error.dart';
import '../data/repositories/notification_repository.dart';
import '../presentation/blocs/notifications/notifications_bloc.dart';
import '../presentation/blocs/notifications/notifications_event.dart';
import '../presentation/blocs/notifications/notifications_state.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkBg = const Color(0xFF181A20);
    final cardBg = const Color(0xFF23262B);
    final textColor = Colors.white;
    return BlocProvider(
      create:
          (_) =>
              NotificationsBloc(repo: context.read<NotificationRepository>())
                ..add(const NotificationsLoad()),
      child: Scaffold(
        backgroundColor: darkBg,
        appBar: AppBar(
          backgroundColor: cardBg,
          title: const Text(
            'Notifications',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: BlocBuilder<NotificationsBloc, NotificationsState>(
          builder: (context, state) {
            if (state.loading)
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            if (state.error != null)
              return LoadingError(
                message: state.error!,
                onRetry:
                    () => context.read<NotificationsBloc>().add(
                      const NotificationsLoad(),
                    ),
              );
            if (state.items.isEmpty)
              return const Center(
                child: Text(
                  'No notifications',
                  style: TextStyle(color: Colors.white70),
                ),
              );

            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: state.items.length,
              separatorBuilder:
                  (_, __) => Divider(height: 1, color: Colors.white24),
              itemBuilder: (_, i) {
                final n = state.items[i];
                return ListTile(
                  tileColor: cardBg,
                  title: Text(n.title, style: TextStyle(color: textColor)),
                  subtitle: Text(
                    n.body,
                    style: TextStyle(color: Colors.white70),
                  ),
                  trailing: Text(
                    '${n.time.hour.toString().padLeft(2, '0')}:${n.time.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(color: Colors.white54),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
