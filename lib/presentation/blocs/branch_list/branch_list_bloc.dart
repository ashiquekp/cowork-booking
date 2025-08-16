import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/branch_repository.dart';
import '../../../models/branch.dart';

part 'branch_list_event.dart';
part 'branch_list_state.dart';

class BranchListBloc extends Bloc<BranchListEvent, BranchListState> {
  final BranchRepository repo;
  BranchListBloc({required this.repo})
    : super(const BranchListState.loading()) {
    on<BranchListLoad>(_onLoad);
    on<BranchListApplyFilter>(_onFilter);
  }

  Future<void> _onLoad(
    BranchListLoad event,
    Emitter<BranchListState> emit,
  ) async {
    emit(const BranchListState.loading());
    try {
      final items = await repo.fetchBranches();
      emit(BranchListState.loaded(items: items));
    } catch (e) {
      emit(BranchListState.error(message: e.toString()));
    }
  }

  Future<void> _onFilter(
    BranchListApplyFilter event,
    Emitter<BranchListState> emit,
  ) async {
    emit(const BranchListState.loading());
    try {
      final items = await repo.fetchBranches(
        query: event.query,
        city: event.city,
        maxPrice: event.maxPrice,
      );
      emit(
        BranchListState.loaded(
          items: items,
          query: event.query,
          city: event.city,
          maxPrice: event.maxPrice,
        ),
      );
    } catch (e) {
      emit(BranchListState.error(message: e.toString()));
    }
  }
}
