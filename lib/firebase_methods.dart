import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:legion/firebase_options.dart';
import 'package:legion/views/register_view_student.dart';
import 'package:legion/views/register_view_staff.dart';
import 'package:legion/views/register_view_faculty.dart';
import 'package:legion/views/EventForm.dart';
import 'package:legion/views/CircularForm.dart';
import 'package:image_picker/image_picker.dart';

String? circularurl;
String? userurl;
String? eventurl;

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
      for (var doc in querySnapshot.docs) {
        users.add(doc.data());
      }
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
      for (var doc in querySnapshot.docs) {
        circulars.add(doc.data());
      }
      return circulars;
    }).catchError((error) {
      print("Failed to retrieve circulars: $error");
    });
  }

  Future<bool> createUser(dynamic userJson) async {
    userJson['img_url'] = userurl;
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

  Future<bool> createRecruit(dynamic userJson) async {
    CollectionReference userProfile =
        FirebaseFirestore.instance.collection('recruit');
    return userProfile.doc(userJson['club']).set(userJson).then((value) {
      print("Recruit Added");
      return true;
    }).catchError((error) {
      print("Failed to add recruit: $error");
      return false;
    });
  }

  Future<bool> applyClub(dynamic val) async {
    CollectionReference userProfile =
        FirebaseFirestore.instance.collection('club_application');
    return userProfile.doc(val['club'] + '_' + val['email']).set(val).then((value) {
      print("Applied club");
      return true;
    }).catchError((error) {
      print("Failed to apply: $error");
      return false;
    });
  }

  Future<bool> applyEvent(dynamic val) async {
    CollectionReference userProfile =
        FirebaseFirestore.instance.collection('event_application');
    return userProfile.doc(val['club'] + '_' + val['email']).set(val).then((value) {
      print("Applied club");
      return true;
    }).catchError((error) {
      print("Failed to apply: $error");
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

  Future<void> joinClub(String documentId, String newClub) async {
  try {
    await FirebaseFirestore.instance
        .collection('profile')
        .doc(documentId)
        .update({'clubs': FieldValue.arrayUnion([newClub])});
  } catch (e) {
    print(e.toString());
  }
}

  Future<bool> createCircular(dynamic circularJson) async {
    circularJson['imageurl']=circularurl;
    CollectionReference circularCollectionRef =
        FirebaseFirestore.instance.collection('circular');
    return circularCollectionRef.add(circularJson).then((value) {
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
    eventJson['imageurl']=eventurl;
    CollectionReference eventCollection =
        FirebaseFirestore.instance.collection('events');
    return eventCollection.add(eventJson).then((value) {
      print("Event Added");
      return true;
    }).catchError((error) {
      print("Failed to add event: $error");
      return false;
    });
  }

  Future selectImageUser(String admin) async {
    try {
      dynamic image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      final Reference storageReference = FirebaseStorage.instance.ref().child("products");
      UploadTask uploadTask = storageReference.child('filesurl/').putFile(imageTemp);

      userurl = await (await uploadTask).ref.getDownloadURL();
      if (admin == '0') {
        student_img_flag[0] = true;
      }
      else if (admin == '1') {
        staff_img_flag[0] = true;
      }
      else {
        faculty_img_flag[0] = true;
      }
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future selectImageCircular() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemp = File(image.path);
      final Reference storageReference = FirebaseStorage.instance.ref().child("products");
      UploadTask uploadTask = storageReference.child('filesurl/').putFile(imageTemp);

      circularurl = await (await uploadTask).ref.getDownloadURL();
      print(circularurl);
      circular_img_flag[0] = true;
    }  catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future selectImageEvent() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemp = File(image.path);
      final Reference storageReference = FirebaseStorage.instance.ref().child("products");
      UploadTask uploadTask = storageReference.child('filesurl/').putFile(imageTemp);

      eventurl = await (await uploadTask).ref.getDownloadURL();
      club_img_flag[0] = true;
    }  catch(e) {
      print('Failed to pick image: $e');
    }
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

  Future<List<dynamic>> getMatchingRecords(
      String collectionName, String deptAndBatch) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(collectionName);
    List res = [];
    return collectionReference
        .where('for', arrayContains: deptAndBatch)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        res.add(doc.data());
      }
      return res;
    });
  }

  Future<List<dynamic>> getClubApplication(
      String collectionName, String club_name) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(collectionName);
    List res = [];
    return collectionReference
        .where('club', isEqualTo: club_name)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        res.add(doc.data());
      }
      return res;
    });
  }

  Future<void> deleteRegistration(String collectionName, String clubName, String email) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection(collectionName).where('club', isEqualTo: clubName).where('email', isEqualTo: email).get().then((querySnapshot){
      querySnapshot.docs.forEach((doc) async {
        await firestore.collection(collectionName).doc(doc.id).delete();
      });
    });
  }

  Future<dynamic> getAllDocumentsWithId(String collectionName) async {
    List<Map<String, dynamic>> documents = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(collectionName).get();
    for (DocumentSnapshot document in snapshot.docs) {
            dynamic data = document.data();
            data['id'] = document.id;
            documents.add(data);
        }
        return documents;
  }

  Future<bool> checkApplicationExists(String email, String club_name) async {
      var query = FirebaseFirestore.instance
          .collection('club_application')
          .where('email', isEqualTo: email)
          .where('club', isEqualTo: club_name)
          .limit(1);

      var snapshot = await query.get();
      return snapshot.docs.length == 1;
  }

  Future<bool> recruitOpen(String club_name) async {
      var query = FirebaseFirestore.instance
          .collection('recruit')
          .where('club', isEqualTo: club_name)
          .limit(1);

      var snapshot = await query.get();
      return snapshot.docs.length == 1;
  }

  Future<void> deleteRecruitsByClub(String clubName) async {
    CollectionReference recruitCollection = FirebaseFirestore.instance.collection('recruit');
    QuerySnapshot snapshot = await recruitCollection.where('club', isEqualTo: clubName).get();
    List<DocumentSnapshot> docs = snapshot.docs;
    for (var doc in docs) {
      await doc.reference.delete();
    }
    print('Deleted all recruits of club $clubName');
    deleteClubApplications(clubName);
  }

  Future<void> deleteClubApplications(String club_name) async {
    try {
      CollectionReference clubApplicationCollection = FirebaseFirestore.instance.collection('club_application');
      QuerySnapshot querySnapshot = await clubApplicationCollection.where('club', isEqualTo: club_name).get();
      querySnapshot.docs.forEach((document) async {
        await document.reference.delete();
      });
      print('Successfully');
    } catch (e) {
      print('Error deleting club_application documents: $e');
    }
  }
}
