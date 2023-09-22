import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String name;
  final String description;
  final Duration duration;
  final DateTime startTime;
  final String imageUrl;
  final String address;

  const Event(this.name, this.description, this.duration, this.startTime,
      this.imageUrl, this.address);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'duration': duration.inSeconds,
      'startTime': Timestamp.fromDate(startTime),
      'imageUrl': imageUrl,
      'address': address,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      map['name'] ?? '',
      map['description'] ?? '',
      Duration(seconds: map['duration']),
      (map['startTime'] as Timestamp).toDate(),
      map['imageUrl'] ?? '',
      map['address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Event(name: $name, description: $description, duration: $duration, startTime: $startTime, imageUrl: $imageUrl, address: $address)';
  }
}
