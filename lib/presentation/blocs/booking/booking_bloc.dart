import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/booking_repository.dart';
import '../../../data/repositories/notification_repository.dart';
import '../../../models/booking.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository repo;
  final NotificationRepository notifications;
  BookingBloc({required this.repo, required this.notifications})
    : super(const BookingState.idle()) {
    on<BookingCreate>(_onCreate);
  }

  Future<void> _onCreate(
    BookingCreate event,
    Emitter<BookingState> emit,
  ) async {
    emit(const BookingState.loading());
    try {
      final booking = await repo.createBooking(
        branchId: event.branchId,
        start: event.start,
        end: event.end,
      );
      await notifications.push(
        title: 'Booking Confirmed',
        body: 'Your booking is scheduled.',
      );
      emit(BookingState.success(booking));
    } catch (e) {
      emit(BookingState.error(e.toString()));
    }
  }
}
