import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_mate/resources/storage_methos.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
FirebaseFirestore _firestore = FirebaseFirestore.instance;
class FirestoreMethos {

  Future<String> addpill({
    required String pillname,
    required String pilltype,
    required String pillamount,
    required String startdate,
    required String enddate,
    required String timming,
     Uint8List? file,
    required int notificationuid,
    required bool isimage,

  })async{
    String res = "error ocurred try again";
    try{
    var uid =Uuid().v1().substring(0, 6);
    String? photoUrl;
    if(isimage){
     photoUrl= await StorageMethods().uploadImageToStorage('profilePics', file!);
    }
      await _firestore.collection('admin').doc(FirebaseAuth.instance.currentUser!.uid).collection('pills').doc(uid).set({
        'uid': uid,
        'pillname':pillname,
        'pilltype':pilltype,
        'pillamount':pillamount,
        'startdate':startdate,
        'enddate':enddate,
        'timming':timming,
        'noteuid':notificationuid,
        'pillimage':photoUrl

      }).onError((error, stackTrace) => res="error ocurred try again");
      res= 'success';
      return res;
    }
    catch(e){
      return res;
    }
  }

  Future<String> delete(String docid) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('admin').doc(FirebaseAuth.instance.currentUser!.uid).collection('pills').doc(docid).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
   Future<String> addquestion(
      {required String question,
        required String option1,
        required String option2,
        required String option3,
        required String option4,
        required String rightans,
      }) async {
    // var uid =;
    // print(uid);
    String res = 'some error occure';
    try{
      await _firestore
          .collection('khush')
            .doc( DateFormat('dd-MM-yyyy- HH:mm:ss').format(DateTime.now()).toString())
          .set({
        'question': question,
        'option1': option1,
        'option2': option2,
        'option3': option3,
        'option4': option4,
        // 'ans': rightans
        // 'quesuid': uid
      }).onError((error, stackTrace) => res = 'some error occure $error');
      res = 'success';
      return res;
    }
    catch(e){
      res = "error occured $e";
    }
    return res;

  }
  Future<String> updateans({
    required String uid,
    required int ans,
  }) async {
    String res = 'erro occured';
    try{
      var uuid = Uuid().v1().substring(0,6);
      await FirebaseFirestore.instance.collection('admin')
          .doc(FirebaseAuth.instance.currentUser!.uid).collection('happiness').
      // doc( DateFormat('dd-MM-yyyy').format(DateTime.now()).toString())
      doc('05-05-2024')
          .collection('questions')
          .doc(uid)
          .set({
        'quesdocid': uid,
        'ans':ans,
          }).catchError((er) {
        res = 'error $er';
      });
      res = 'success';
      return res;
    }
    catch(e){
      res = 'error occured $e';
    }
    return res;
  }

  Future<String> submitQuestion() async {
    String res = 'erro occured';
    try{

      await FirebaseFirestore.instance.collection('admin')
          .doc(FirebaseAuth.instance.currentUser!.uid).collection('happiness').doc( DateFormat('dd-MM-yyyy').format(DateTime.now()).toString())
          .set({
        'status': true,
      }).catchError((er) {
        res = 'error $er';
      });
      res = 'success';
      return res;
    }
    catch(e){
      res = 'error occured $e';
    }
    return res;
  }


}
