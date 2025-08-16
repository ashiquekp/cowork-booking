import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/booking_repository.dart';
import '../../../models/booking.dart';

part 'my_bookings_event.dart';
part 'my_bookings_state.dart';

class MyBookingsBloc extends Bloc<MyBookingsEvent, MyBookingsState> {
  final BookingRepository repo;
  MyBookingsBloc({required this.repo})
    : super(const MyBookingsState.loading()) {
    on<MyBookingsLoad>(_onLoad);
  }

  Future<void> _onLoad(
    MyBookingsLoad event,
    Emitter<MyBookingsState> emit,
  ) async {
    emit(const MyBookingsState.loading());
    try {
      final items = await repo.myBookings();
      emit(MyBookingsState.loaded(items));
    } catch (e) {
      emit(MyBookingsState.error(e.toString()));
    }
  }
}
