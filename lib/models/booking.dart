import 'package:equatable/equatable.dart';

enum BookingStatus { upcoming, completed }

class Booking extends Equatable {
  final String id;
  final String branchId;
  final DateTime start;
  final DateTime end;
  final BookingStatus status;

  const Booking({
    required this.id,
    required this.branchId,
    required this.start,
    required this.end,
    required this.status,
  });

  Booking copyWith({BookingStatus? status}) => Booking(
    id: id,
    branchId: branchId,
    start: start,
    end: end,
    status: status ?? this.status,
  );

  @override
  List<Object?> get props => [id, branchId, start, end, status];
}
