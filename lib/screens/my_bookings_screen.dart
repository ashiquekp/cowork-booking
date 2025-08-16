import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../core/widgets/loading_error.dart';
import '../data/repositories/booking_repository.dart';
import '../presentation/blocs/my_bookings/my_bookings_bloc.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkBg = const Color(0xFF181A20);
    final cardBg = const Color(0xFF23262B);
    final textColor = Colors.white;
    return BlocProvider(
      create:
          (_) =>
              MyBookingsBloc(repo: context.read<BookingRepository>())
                ..add(const MyBookingsLoad()),
      child: Scaffold(
        backgroundColor: darkBg,
        appBar: AppBar(
          backgroundColor: cardBg,
          title: const Text(
            'My Bookings',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: BlocBuilder<MyBookingsBloc, MyBookingsState>(
          builder: (context, state) {
            if (state.loading)
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            if (state.error != null)
              return LoadingError(
                message: state.error!,
                onRetry:
                    () => context.read<MyBookingsBloc>().add(
                      const MyBookingsLoad(),
                    ),
              );
            if (state.items.isEmpty)
              return const Center(
                child: Text(
                  'No bookings yet',
                  style: TextStyle(color: Colors.white70),
                ),
              );

            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: state.items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) {
                final b = state.items[i];
                final range =
                    '${DateFormat('MMM d, HH:mm').format(b.start)} - ${DateFormat('HH:mm').format(b.end)}';
                final chip = Chip(
                  label: Text(
                    b.status.name.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: cardBg,
                );
                return ListTile(
                  tileColor: cardBg,
                  title: Text(range, style: TextStyle(color: textColor)),
                  subtitle: Text(
                    'Branch: ${b.branchId}',
                    style: TextStyle(color: Colors.white70),
                  ),
                  trailing: chip,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
