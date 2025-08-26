import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../data/repositories/booking_repository.dart';
import '../data/repositories/notification_repository.dart';
import '../models/branch.dart';
import '../presentation/blocs/booking/booking_bloc.dart';

class BookingScreen extends StatefulWidget {
  final Branch branch;
  const BookingScreen({super.key, required this.branch});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _date;
  TimeOfDay? _start;
  TimeOfDay? _end;

  @override
  Widget build(BuildContext context) {
    final darkBg = const Color(0xFF181A20);
    final cardBg = const Color(0xFF23262B);
    final textColor = Colors.white;
    return BlocProvider(
      create:
          (_) => BookingBloc(
            repo: context.read<BookingRepository>(),
            notifications: context.read<NotificationRepository>(),
          ),
      child: Scaffold(
        backgroundColor: darkBg,
        appBar: AppBar(
          backgroundColor: cardBg,
          title: const Text(
            'Select Date & Time',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: BlocConsumer<BookingBloc, BookingState>(
          listener: (context, state) {
            if (state.booking != null) {
              showDialog(
                context: context,
                builder:
                    (_) => AlertDialog(
                      backgroundColor: cardBg,
                      title: const Text(
                        'Booking Confirmed',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: Text(
                        'Your booking is scheduled on ${DateFormat('MMM d, yyyy • HH:mm').format(state.booking!.start)}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      actions: [
                        TextButton(
                          onPressed:
                              () =>
                                  Navigator.popUntil(context, (r) => r.isFirst),
                          child: const Text(
                            'OK',
                            style: TextStyle(color: Colors.deepPurpleAccent),
                          ),
                        ),
                      ],
                    ),
              );
            }
            if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.error!,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red[900],
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.branch.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: cardBg,
                            side: const BorderSide(color: Colors.white24),
                          ),
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 60),
                              ),
                              initialDate: _date ?? DateTime.now(),
                              builder:
                                  (ctx, child) => Theme(
                                    data: ThemeData.dark(),
                                    child: child!,
                                  ),
                            );
                            if (picked != null) setState(() => _date = picked);
                          },
                          child: Text(
                            _date == null
                                ? 'Pick date'
                                : DateFormat('EEE, MMM d').format(_date!),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: cardBg,
                            side: const BorderSide(color: Colors.white24),
                          ),
                          onPressed: () async {
                            final picked = await showTimePicker(
                              context: context,
                              initialTime: _start ?? TimeOfDay.now(),
                              builder:
                                  (ctx, child) => Theme(
                                    data: ThemeData.dark(),
                                    child: child!,
                                  ),
                            );
                            if (picked != null) setState(() => _start = picked);
                          },
                          child: Text(
                            _start == null
                                ? 'Start time'
                                : _start!.format(context),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: cardBg,
                            side: const BorderSide(color: Colors.white24),
                          ),
                          onPressed: () async {
                            final picked = await showTimePicker(
                              context: context,
                              initialTime: _end ?? TimeOfDay.now(),
                              builder:
                                  (ctx, child) => Theme(
                                    data: ThemeData.dark(),
                                    child: child!,
                                  ),
                            );
                            if (picked != null) setState(() => _end = picked);
                          },
                          child: Text(
                            _end == null ? 'End time' : _end!.format(context),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                      ),
                      onPressed:
                          state.loading
                              ? null
                              : () {
                                if (_date == null ||
                                    _start == null ||
                                    _end == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Pick date and time',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }
                                final start = DateTime(
                                  _date!.year,
                                  _date!.month,
                                  _date!.day,
                                  _start!.hour,
                                  _start!.minute,
                                );
                                final end = DateTime(
                                  _date!.year,
                                  _date!.month,
                                  _date!.day,
                                  _end!.hour,
                                  _end!.minute,
                                );
                                if (end.isBefore(start)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'End must be after start',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }
                                context.read<BookingBloc>().add(
                                  
                                  BookingCreate(
                                    branchId: widget.branch.id,
                                    start: start,
                                    end: end,
                                  ),
                                );
                              },
                      child:
                          state.loading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : const Text('Confirm booking'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
