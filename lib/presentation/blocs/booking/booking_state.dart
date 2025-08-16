part of 'booking_bloc.dart';

class BookingState extends Equatable {
  final bool loading;
  final Booking? booking;
  final String? error;

  const BookingState._({required this.loading, this.booking, this.error});

  const BookingState.idle() : this._(loading: false);
  const BookingState.loading() : this._(loading: true);
  const BookingState.success(Booking booking)
    : this._(loading: false, booking: booking);
  const BookingState.error(String message)
    : this._(loading: false, error: message);

  @override
  List<Object?> get props => [loading, booking, error];
}
