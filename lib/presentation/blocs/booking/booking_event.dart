part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();
  @override
  List<Object?> get props => [];
}

class BookingCreate extends BookingEvent {
  final String branchId;
  final DateTime start;
  final DateTime end;
  const BookingCreate({
    required this.branchId,
    required this.start,
    required this.end,
  });
}
