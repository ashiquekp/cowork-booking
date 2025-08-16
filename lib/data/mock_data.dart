import '../models/branch.dart';

final mockBranches = <Branch>[
  Branch(
    id: 'b1',
    name: 'Indigo Works',
    city: 'Bengaluru',
    address: 'MG Road, Bengaluru',
    pricePerHour: 200,
    lat: 12.9716,
    lng: 77.5946,
    imageUrls: [
      'https://images.unsplash.com/photo-1504384308090-c894fdcc538d',
      'https://images.unsplash.com/photo-1524758631624-e2822e304c36',
    ],
    amenities: ['Wi‑Fi', 'AC', 'Meeting Rooms', 'Coffee'],
    description:
        'Bright, modern cowork with flexible hot desks and private cabins.',
    openingHours: 'Mon–Sat 8:00–21:00',
  ),
  Branch(
    id: 'b2',
    name: 'Urban Desk',
    city: 'Mumbai',
    address: 'BKC, Mumbai',
    pricePerHour: 250,
    lat: 19.0678,
    lng: 72.8677,
    imageUrls: ['https://images.unsplash.com/photo-1497366216548-37526070297c'],
    amenities: ['Wi‑Fi', '24/7 Access', 'Pantry'],
    description:
        'Minimalist space with plenty of natural light and fast internet.',
    openingHours: 'Mon–Sun 7:00–22:00',
  ),
  Branch(
    id: 'b3',
    name: 'Civic Hub',
    city: 'Kochi',
    address: 'Infopark, Kochi',
    pricePerHour: 150,
    lat: 9.9816,
    lng: 76.2999,
    imageUrls: ['https://images.unsplash.com/photo-1529336953121-a0ce9a6b2a0c'],
    amenities: ['Wi‑Fi', 'Parking', 'Conference Hall'],
    description:
        'Cost-effective, comfy seating and quiet zones for focused work.',
    openingHours: 'Mon–Fri 9:00–20:00',
  ),
];
