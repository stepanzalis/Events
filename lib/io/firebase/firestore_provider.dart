import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uhk_events/io/entities/general_info_entity.dart';
import 'package:uhk_events/io/entities/main_event_entity.dart';
import 'package:uhk_events/io/entities/scheduled_event_entity.dart';
import 'package:uhk_events/io/entities/user_entity.dart';
import 'package:uhk_events/io/model/general_info.dart';
import 'package:uhk_events/io/model/main_event.dart';
import 'package:uhk_events/io/model/scheduled_event.dart';

class FirestoreProvider {
  final Firestore _firestore = Firestore.instance;

  Future<bool> isConferenceType(String id) async {
    final snapShot = await _firestore.collection('events').document(id).get();
    return snapShot != null && snapShot.exists;
  }

  Future<void> sendFirebaseToken(String token) =>
      _firestore.collection('users').add({"firebaseToken": token});

  Future<List<MainEvent>> fetchMainEvents() => _firestore
      .collection('events')
      .orderBy('isActive', descending: true)
      .getDocuments()
      .then((list) => list.documents
          .map((doc) => MainEvent.fromEntity(MainEventEntity.fromSnapshot(doc)))
          .toList());

  Future<List<ScheduledEvent>> fetchScheduleFromEvent(String eventId) =>
      _firestore
          .collection('events')
          .document(eventId)
          .collection('schedule')
          .getDocuments()
          .then((list) => list.documents
              .map((doc) => ScheduledEvent.fromEntity(
                  ScheduledEventEntity.fromSnapshot(doc)))
              .toList());

  Future<String> sendUser(UserEntity user, String eventId) =>
      _firestore.collection('users').add(user.toDocument()).then((value) {
        return value.documentID;
      });

  Future<GeneralInfo> fetchGeneralInfo() =>
      _firestore.collection('generalInfo').getDocuments().then((list) {
        return GeneralInfo.fromEntity(
            GeneralInfoEntity.fromSnapshot(list.documents[0]));
      });

  Future<void> postSchedule(
          String userId, String eventId, ScheduledEvent event) =>
      _firestore
          .collection('users')
          .document(userId)
          .collection('mySchedule')
          .document(eventId)
          .collection('schedule')
          .add(event.toEntity().toDocument());

  Future<void> removeSchedule(
          String userId, String eventId, String scheduleEventId) =>
      _firestore
          .collection('users')
          .document(userId)
          .collection('mySchedule')
          .document(eventId)
          .collection('schedule')
          .document(scheduleEventId)
          .delete();
}
