import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to write field data to a collection
  Future<void> writeDataToCollection(
      String collectionName, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionName).add(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error writing data to collection: $e');
      }
    }
  }

  // Function to update field data in a document
  Future<void> updateDataInDocument(String collectionName, String documentId,
      Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionName).doc(documentId).update(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error updating data in document: $e');
      }
    }
  }

  // Function to delete a document from a collection
  Future<void> deleteDocument(String collectionName, String documentId) async {
    try {
      await _firestore.collection(collectionName).doc(documentId).delete();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting document: $e');
      }
    }
  }

  // Function to get a single document from a collection
  Future<DocumentSnapshot<Object?>?> getDocument(
      String collectionName, String documentId) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection(collectionName).doc(documentId).get();
      return documentSnapshot;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting document: $e');
      }
      return null;
    }
  }

  // Function to get all documents from a collection
  Future<List<QueryDocumentSnapshot<Object?>>?> getAllDocuments(
      String collectionName) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(collectionName).get();
      return querySnapshot.docs;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting all documents: $e');
      }
      return null;
    }
  }

  // Function to query documents in a collection based on a field value
  Future<List<QueryDocumentSnapshot<Object?>>?> queryDocuments(
      String collectionName, String fieldName, dynamic fieldValue) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(collectionName)
          .where(fieldName, isEqualTo: fieldValue)
          .get();
      return querySnapshot.docs;
    } catch (e) {
      if (kDebugMode) {
        print('Error querying documents: $e');
      }
      return null;
    }
  }
}
