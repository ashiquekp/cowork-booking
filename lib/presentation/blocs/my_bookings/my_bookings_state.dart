part of 'my_bookings_bloc.dart';

class MyBookingsState extends Equatable {
  final bool loading;
  final String? error;
  final List<Booking> items;

  const MyBookingsState._({
    required this.loading,
    this.error,
    required this.items,
  });

  const MyBookingsState.loading() : this._(loading: true, items: const []);
  const MyBookingsState.error(String message)
    : this._(loading: false, error: message, items: const []);
  const MyBookingsState.loaded(List<Booking> items)
    : this._(loading: false, items: items);

  @override
  List<Object?> get props => [loading, error, items];
}
