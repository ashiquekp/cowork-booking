import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/app_router.dart';
import '../core/widgets/branch_card.dart';
import '../core/widgets/loading_error.dart';
import '../data/repositories/branch_repository.dart';
import '../presentation/blocs/branch_list/branch_list_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              BranchListBloc(repo: context.read<BranchRepository>())
                ..add(const BranchListLoad()),
      child: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatefulWidget {
  const _HomeBody();

  @override
  State<_HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<_HomeBody> {
  final _searchCtrl = TextEditingController();
  String? _selectedCity;
  double? _maxPrice;

  @override
  Widget build(BuildContext context) {
    final darkBg = const Color(0xFF181A20);
    final cardBg = const Color(0xFF23262B);
    //final accent = Theme.of(context).colorScheme.secondary;
    final textColor = Colors.white;
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: cardBg,
        title: const Text(
          'Cowork Branches',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, AppRouter.map),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed:
                () => Navigator.pushNamed(context, AppRouter.notifications),
          ),
          IconButton(
            icon: const Icon(Icons.event_note_outlined, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, AppRouter.myBookings),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: cardBg,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white70,
                      ),
                      hintText: 'Search by name, city, or branch',
                      hintStyle: TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => _apply(context),
                  ),
                ),
                const SizedBox(width: 8),
                _FilterButton(
                  onApply: (city, maxPrice) {
                    _selectedCity = city;
                    _maxPrice = maxPrice;
                    _apply(context);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<BranchListBloc, BranchListState>(
              builder: (context, state) {
                if (state.loading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                if (state.error != null) {
                  return LoadingError(
                    message: state.error!,
                    onRetry: () => _apply(context),
                  );
                }
                if (state.items.isEmpty) {
                  return const Center(
                    child: Text(
                      'No branches match your filters.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: state.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder:
                      (_, i) => BranchCard(
                        branch: state.items[i],
                        onTap:
                            (b) => Navigator.pushNamed(
                              context,
                              AppRouter.detail,
                              arguments: b,
                            ),
                      ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _apply(BuildContext context) {
    context.read<BranchListBloc>().add(
      BranchListApplyFilter(
        query: _searchCtrl.text,
        city: _selectedCity,
        maxPrice: _maxPrice,
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final void Function(String? city, double? maxPrice) onApply;
  const _FilterButton({required this.onApply});

  @override
  Widget build(BuildContext context) {
    final cardBg = const Color(0xFF23262B);
    final textColor = Colors.white;
    return OutlinedButton.icon(
      icon: const Icon(Icons.filter_alt_outlined, color: Colors.white),
      label: const Text('Filter', style: TextStyle(color: Colors.white)),
      style: OutlinedButton.styleFrom(
        backgroundColor: cardBg,
        side: const BorderSide(color: Colors.white24),
      ),
      onPressed: () async {
        String? city;
        double? price;
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: cardBg,
          builder: (ctx) {
            final cityCtrl = TextEditingController();
            final priceCtrl = TextEditingController();
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
                top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: cityCtrl,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      labelText: 'City',
                      labelStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: cardBg,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: priceCtrl,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      labelText: 'Max price/hour',
                      labelStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: cardBg,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        city =
                            cityCtrl.text.trim().isEmpty
                                ? null
                                : cityCtrl.text.trim();
                        if (priceCtrl.text.trim().isNotEmpty) {
                          price = double.tryParse(priceCtrl.text.trim());
                        }
                        Navigator.pop(ctx);
                      },
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
        onApply(city, price);
      },
    );
  }
}
