import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../core/app_router.dart';
import '../models/branch.dart';

class DetailScreen extends StatelessWidget {
  final Branch branch;
  const DetailScreen({super.key, required this.branch});

  @override
  Widget build(BuildContext context) {
    final darkBg = const Color(0xFF181A20);
    final cardBg = const Color(0xFF23262B);
    final textColor = Colors.white;
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: cardBg,
        title: Text(branch.name, style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(
            height: 180,
            child: PageView.builder(
              itemCount: branch.imageUrls.length,
              itemBuilder:
                  (_, i) => ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: branch.imageUrls[i],
                      fit: BoxFit.cover,
                    ),
                  ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.place, color: Colors.deepPurpleAccent),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${branch.address}, ${branch.city}',
                  style: TextStyle(color: textColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '₹${branch.pricePerHour.toStringAsFixed(0)}/hour',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(branch.description, style: TextStyle(color: textColor)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                branch.amenities
                    .map(
                      (a) => Chip(
                        label: Text(
                          a,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: cardBg,
                      ),
                    )
                    .toList(),
          ),
          const SizedBox(height: 16),
          Text(
            'Hours: ${branch.openingHours}',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              onPressed:
                  () => Navigator.pushNamed(
                    context,
                    AppRouter.booking,
                    arguments: branch,
                  ),
              child: const Text('Book now'),
            ),
          ),
        ],
      ),
    );
  }
}
