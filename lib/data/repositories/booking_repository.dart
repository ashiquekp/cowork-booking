import 'dart:async';
import 'package:collection/collection.dart';
import '../../models/booking.dart';

class BookingRepository {
  final _bookings = <Booking>[];

  Future<List<Booking>> myBookings() async {
    await Future.delayed(const Duration(milliseconds: 400));
    // Auto-mark past as completed
    final now = DateTime.now();
    for (var i = 0; i < _bookings.length; i++) {
      final b = _bookings[i];
      if (b.end.isBefore(now) && b.status == BookingStatus.upcoming) {
        _bookings[i] = b.copyWith(status: BookingStatus.completed);
      }
    }
    return List.unmodifiable(_bookings.sortedBy((b) => b.start));
  }

  Future<Booking> createBooking({
    required String branchId,
    required DateTime start,
    required DateTime end,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final booking = Booking(
      id: id,
      branchId: branchId,
      start: start,
      end: end,
      status: BookingStatus.upcoming,
    );
    _bookings.add(booking);
    return booking;
  }
}
