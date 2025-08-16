import 'dart:async';
import 'package:cowork_booking_app/data/mock_data.dart';
import '../../models/branch.dart';

class BranchRepository {
  Future<List<Branch>> fetchBranches({
    String? query,
    String? city,
    double? maxPrice,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    var list = mockBranches;
    if (query != null && query.trim().isNotEmpty) {
      final q = query.toLowerCase();
      list =
          list
              .where(
                (b) =>
                    b.name.toLowerCase().contains(q) ||
                    b.city.toLowerCase().contains(q) ||
                    b.address.toLowerCase().contains(q),
              )
              .toList();
    }
    if (city != null && city.isNotEmpty) {
      list =
          list
              .where((b) => b.city.toLowerCase() == city.toLowerCase())
              .toList();
    }
    if (maxPrice != null) {
      list = list.where((b) => b.pricePerHour <= maxPrice).toList();
    }
    return list;
  }
}
