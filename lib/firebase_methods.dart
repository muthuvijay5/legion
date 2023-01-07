import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:legion/firebase_options.dart';

dynamic userJson = {
  'name': "A",
  'email': "A",
  'activated': false,
  'batch': 12,
  'clubs': ["p club"],
  'dept': 'it',
  'dob': '123',
  'gender': 'A',
  'phone': 123,
  'photoImgLink': 'l',
  'role': 'a',
  'rollno': '123'
};

// ignore: non_constant_identifier_names
// Firebase.initializeApp(
//         options: DefaultFirebaseOptions.currentPlatform,
//       );

// Future<Void> createUser(dynamic userJson) async {
//   CollectionReference userProfile =
//       FirebaseFirestore.instance.collection('profile');
//   returnuserProfile.doc(userJson['email']).set(userJson).then((value) {
//     print("User Added");
//     return true;
//   }).catchError((error) {
//     print("Failed to add user: $error");
//     return false;
//   });
// }

void main() {
  bool x = true;
}

class FirebaseMethods {
  Future<List> findEvents(dynamic attribute, dynamic value) async {
    CollectionReference eventCollection =
        FirebaseFirestore.instance.collection('events');
    return eventCollection
        .where(attribute, isEqualTo: value)
        .get()
        .then((QuerySnapshot querySnapshot) {
      List events = [];
      querySnapshot.docs.forEach((doc) {
        events.add(doc.data());
      });
      return events;
    }).catchError((error) {
      print("Failed to retrieve events: $error");
    });
  }

  Future<List> findUsers(dynamic attribute, dynamic value) async {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('profile');
    return userCollection
        .where(attribute, isEqualTo: value)
        .get()
        .then((QuerySnapshot querySnapshot) {
      List users = [];
      querySnapshot.docs.forEach((doc) {
        users.add(doc.data());
      });
      return users;
    }).catchError((error) {
      print("Failed to retrieve users: $error");
    });
  }

  Future<List> findCircular(dynamic attribute, dynamic value) async {
    CollectionReference circularCollection =
        FirebaseFirestore.instance.collection('circular');
    return circularCollection
        .where(attribute, isEqualTo: value)
        .get()
        .then((QuerySnapshot querySnapshot) {
      List circulars = [];
      querySnapshot.docs.forEach((doc) {
        circulars.add(doc.data());
      });
      return circulars;
    }).catchError((error) {
      print("Failed to retrieve circulars: $error");
    });
  }

  Future<bool> createUser(dynamic userJson) async {
    CollectionReference userProfile =
        FirebaseFirestore.instance.collection('profile');
    return userProfile.doc(userJson['email']).set(userJson).then((value) {
      print("User Added");
      return true;
    }).catchError((error) {
      print("Failed to add user: $error");
      return false;
    });
  }

  Future<bool> updateProfileDetails(
      String mail, String attribute, dynamic value) async {
    CollectionReference userProfileCollection =
        FirebaseFirestore.instance.collection('profile');
    return userProfileCollection
        .doc(mail)
        .update({attribute: value}).then((value) {
      return true;
    }).catchError((error) {
      print("Failed to update user profile: $error");
      return false;
    });
  }

  Future<bool> createCircular(dynamic circularJson) {
    CollectionReference circularCollectionRef =
        FirebaseFirestore.instance.collection('circular');
    return circularCollectionRef
        .doc(circularJson['imgLink'])
        .set(circularJson)
        .then((value) {
      print('Circular Added');
      return true;
    }).catchError((error) {
      print("Failed to add circular: $error");
      return false;
    });
  }

  Future<bool> updateCircularDetails(
      String imgLink, String attribute, dynamic value) async {
    CollectionReference circularCollection =
        FirebaseFirestore.instance.collection('circular');
    return circularCollection
        .doc(imgLink)
        .update({attribute: value}).then((value) {
      print("Circular Updated!");
      return true;
    }).catchError((error) {
      print("Failed to update circular: $error");
      return false;
    });
  }

  Future<bool> createEvent(dynamic eventJson) async {
    CollectionReference eventCollection =
        FirebaseFirestore.instance.collection('events');
    return eventCollection.doc(eventJson['title']).set(eventJson).then((value) {
      print("Event Added");
      return true;
    }).catchError((error) {
      print("Failed to add event: $error");
      return false;
    });
  }

  Future<bool> updateEventDetails(
      String title, String attribute, dynamic value) async {
    CollectionReference eventCollection =
        FirebaseFirestore.instance.collection('events');
    return eventCollection.doc(title).update({attribute: value}).then((value) {
      print("Event Updated!");
      return true;
    }).catchError((error) {
      print("Failed to update event: $error");
      return false;
    });
  }

  Future<bool> deleteEvent(String title) async {
    CollectionReference eventCollection =
        FirebaseFirestore.instance.collection('events');
    return eventCollection.doc(title).delete().then((value) {
      print("Event Deleted");
      return true;
    }).catchError((error) {
      print("Cannot delete event $error");
      return false;
    });
  }

  Future<bool> deleteUser(String mail) async {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('profile');
    return userCollection.doc(mail).delete().then((value) {
      print("User Deleted");
      return true;
    }).catchError((error) {
      print("Cannot delete user $error");
      return false;
    });
  }

  Future<bool> deleteCircular(String imgLink) async {
    CollectionReference circularCollection =
        FirebaseFirestore.instance.collection('circular');
    return circularCollection.doc(imgLink).delete().then((value) {
      print("Circular Deleted");
      return true;
    }).catchError((error) {
      print("Cannot delete circular $error");
      return false;
    });
  }
}
