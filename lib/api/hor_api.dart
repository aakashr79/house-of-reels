import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:house_of_reels/api/models/event.dart';

final firestore = FirebaseFirestore.instance;

class HorApi {
  Future<List<Event>> getEvents() async {
    final events = await firestore.collection("events").get();
    return events.docs.map((e) => Event.fromMap(e.data())).toList();
  }
}
