part of 'branch_list_bloc.dart';

abstract class BranchListEvent extends Equatable {
  const BranchListEvent();
  @override
  List<Object?> get props => [];
}

class BranchListLoad extends BranchListEvent {
  const BranchListLoad();
}

class BranchListApplyFilter extends BranchListEvent {
  final String? query;
  final String? city;
  final double? maxPrice;
  const BranchListApplyFilter({this.query, this.city, this.maxPrice});

  @override
  List<Object?> get props => [query, city, maxPrice];
}
