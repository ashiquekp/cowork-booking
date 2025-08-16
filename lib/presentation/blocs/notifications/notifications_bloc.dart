import 'package:cowork_booking_app/presentation/blocs/notifications/notifications_event.dart';
import 'package:cowork_booking_app/presentation/blocs/notifications/notifications_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/notification_repository.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationRepository repo;
  NotificationsBloc({required this.repo})
    : super(const NotificationsState.loading()) {
    on<NotificationsLoad>(_onLoad);
  }

  Future<void> _onLoad(
    NotificationsLoad event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(const NotificationsState.loading());
    try {
      final items = await repo.fetch();
      emit(NotificationsState.loaded(items));
    } catch (e) {
      emit(NotificationsState.error(e.toString()));
    }
  }
}
