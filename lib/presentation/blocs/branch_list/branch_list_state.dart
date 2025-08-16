part of 'branch_list_bloc.dart';

class BranchListState extends Equatable {
  final bool loading;
  final String? error;
  final List<Branch> items;
  final String? query;
  final String? city;
  final double? maxPrice;

  const BranchListState._({
    required this.loading,
    required this.error,
    required this.items,
    this.query,
    this.city,
    this.maxPrice,
  });

  const BranchListState.loading()
    : this._(loading: true, error: null, items: const []);
  const BranchListState.error({required String message})
    : this._(loading: false, error: message, items: const []);
  const BranchListState.loaded({
    required List<Branch> items,
    String? query,
    String? city,
    double? maxPrice,
  }) : this._(
         loading: false,
         error: null,
         items: items,
         query: query,
         city: city,
         maxPrice: maxPrice,
       );

  @override
  List<Object?> get props => [loading, error, items, query, city, maxPrice];
}
