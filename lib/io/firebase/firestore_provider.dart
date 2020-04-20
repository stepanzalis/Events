import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uhk_events/io/entities/general_info_entity.dart';
import 'package:uhk_events/io/entities/main_event_entity.dart';
import 'package:uhk_events/io/entities/main_event_item_entity.dart';
import 'package:uhk_events/io/entities/wifi_info_entity.dart';
import 'package:uhk_events/io/model/general_info.dart';
import 'package:uhk_events/io/model/main_event.dart';
import 'package:uhk_events/io/model/scheduled_event.dart';
import 'package:uhk_events/io/model/wifi_info.dart';

class FirestoreProvider {
  final Firestore firestore;

  FirestoreProvider({@required this.firestore})
      : assert(firestore != null, "Provide Firestore.instance!");

  Future<bool> isConferenceType(String id) async {
    final snapShot = await firestore.collection('events').document(id).get();
    return snapShot != null && snapShot.exists;
  }

  Future<String> sendFirebaseToken(String token) async {
    final reference = firestore.collection('users').document();
    await reference.setData({"firebaseToken": token});
    return reference.documentID;
  }

  Future<List<String>> fetchMainEvents() => firestore
      .collection('events')
      .getDocuments()
      .then((list) => list.documents.map((doc) => doc.documentID).toList());

  Future<WifiInfo> fetchWifiInfo() => firestore
      .collection('generalInfo')
      .document('wifi')
      .get()
      .then((document) =>
          WifiInfo.fromEntity(WifiInfoEntity.fromDocument(document)));

  Future<MainEvent> fetchMainEventInfo(String id) => firestore
      .collection('events')
      .getDocuments()
      .then((list) => list.documents
          .where((doc) => doc.documentID == id)
          .map((doc) => MainEvent.fromEntity(MainEventEntity.fromSnapshot(doc)))
          .first);

  Future<List<MainEventItem>> fetchScheduleFromEvent(String eventId) =>
      firestore
          .collection('events')
          .document(eventId)
          .collection('schedule')
          .getDocuments()
          .then((list) => list.documents
              .map((doc) => MainEventItem.fromEntity(
                  MainEventItemEntity.fromSnapshot(doc, eventId)))
              .toList());

  Future<GeneralInfo> fetchGeneralInfo() =>
      firestore.collection('generalInfo').getDocuments().then((list) {
        return GeneralInfo.fromEntity(
            GeneralInfoEntity.fromSnapshot(list.documents[0]));
      });

  Future<void> postSchedule(
          String userId, String eventId, MainEventItem event) =>
      firestore
          .collection('users')
          .document(userId)
          .collection('mySchedule')
          .document(eventId)
          .collection('schedule')
          .document(event.id)
          .setData(event.toEntity().toDocument());

  Future<void> removeSchedule(
          String userId, String eventId, String scheduleEventId) =>
      firestore
          .collection('users')
          .document(userId)
          .collection('mySchedule')
          .document(eventId)
          .collection('schedule')
          .document(scheduleEventId)
          .delete();

  Future<List<MainEventItem>> fetchScheduleFromUser(
          String userId, String eventId) =>
      firestore
          .collection('users')
          .document(userId)
          .collection('mySchedule')
          .document(eventId)
          .collection('schedule')
          .getDocuments()
          .then(
            (list) => list.documents
                .map((doc) => MainEventItem.fromEntity(
                    MainEventItemEntity.fromSnapshot(doc, eventId)))
                .toList(),
          );
}
