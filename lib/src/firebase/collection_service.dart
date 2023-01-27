// import 'package:cloud_firestore/cloud_firestore.dart';

// abstract class FirestoreCollectionService {
//   String get tableName;

//   late final collection = FirebaseFirestore.instance.collection(tableName);

//   fromJson(Map<String, dynamic> json) {}

//   String get createdField {
//     return "created";
//   }

//   String get updatedField {
//     return "updated";
//   }

//   Future<String> createDocument(Map<String, dynamic> data,
//       {String? docId}) async {
//     final nowIso = DateTime.now().toUtc().toIso8601String();
//     var dId = docId ?? collection.doc().id;
//     data.remove("id");
//     data[createdField] = nowIso;
//     data[updatedField] = nowIso;
//     await collection.doc(dId).set({
//       "id": dId,
//       ...data,
//     });
//     return dId;
//   }

//   Future<List<T>> fetchAll<T>() async {
//     var result = await collection.orderBy(createdField, descending: true).get();
//     return result.docs.map((e) {
//       var data = e.data();
//       return fromJson(data) as T;
//     }).toList();
//   }

//   Future<void> updateDocument(String id, Map<String, dynamic> data) async {
//     final nowIso = DateTime.now().toUtc().toIso8601String();
//     await collection.doc(id).update({
//       ...data,
//       "updated": nowIso,
//     });
//   }
// }
