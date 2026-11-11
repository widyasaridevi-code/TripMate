
class TripModel {
  final int? id;
  final String destination;
  final String location;
  final String date;
  final String status;
  final String image;

  const TripModel({
    this.id,
    required this.destination,
    required this.location,
    required this.date,
    required this.status,
    this.image = '',
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'] as int?,
      destination: json['destination']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      date: (json['travel_date'] ?? json['date'] ?? '').toString(),
      status: json['status']?.toString() ?? 'Upcoming',
      image: json['image']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'destination': destination,
      'location': location,
      'travel_date': date,
      'status': status,
      'image': image,
    };
  }
}
