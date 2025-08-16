import 'package:equatable/equatable.dart';

class Branch extends Equatable {
  final String id;
  final String name;
  final String city;
  final String address;
  final double pricePerHour;
  final double lat;
  final double lng;
  final List<String> imageUrls;
  final List<String> amenities; // simple strings
  final String description;
  final String openingHours; // e.g., "Mon-Fri 8:00-20:00"

  const Branch({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.pricePerHour,
    required this.lat,
    required this.lng,
    required this.imageUrls,
    required this.amenities,
    required this.description,
    required this.openingHours,
  });

  @override
  List<Object?> get props => [id, name, city, address, pricePerHour, lat, lng];
}
