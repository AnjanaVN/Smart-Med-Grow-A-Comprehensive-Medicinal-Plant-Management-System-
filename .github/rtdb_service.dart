import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class RealtimeDatabaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Function to write data to a specific path in the Realtime Database
  Future<void> writeData(String path, dynamic data) async {
    try {
      await _database.child(path).set(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error writing data to Realtime Database: $e');
      }
    }
  }

  // Function to update data at a specific path in the Realtime Database
  Future<void> updateData(String path, dynamic data) async {
    try {
      await _database.child(path).update(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error updating data in Realtime Database: $e');
      }
    }
  }

  // Function to delete data at a specific path in the Realtime Database
  Future<void> deleteData(String path) async {
    try {
      await _database.child(path).remove();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting data from Realtime Database: $e');
      }
    }
  }

  // Function to read data from a specific path in the Realtime Database
  Future<DatabaseEvent?> readData(String path) async {
    try {
      DatabaseEvent dataSnapshot = await _database.child(path).once();
      return dataSnapshot;
    } catch (e) {
      if (kDebugMode) {
        print('Error reading data from Realtime Database: $e');
      }
      return null;
    }
  }

  // Function to listen for changes in data at a specific path in the Realtime Database
  Stream<DatabaseEvent>? listenForChanges(String path) {
    try {
      return _database.child(path).onValue;
    } catch (e) {
      if (kDebugMode) {
        print('Error listening for changes in Realtime Database: $e');
      }
      return null;
    }
  }
}
