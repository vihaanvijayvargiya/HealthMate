import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
class Meet{

 FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String>addAppoinmentStatus(String name,String appointmentTime1,String googleMeetUrl1,String appointmentTime2,String googleMeetUrl2,String appointmentTime3,String googleMeetUrl3)async{
     var uid =const Uuid().v1().substring(0, 6);
    String res='';
         await _firestore.collection('Appointment').doc(DateFormat('dd-MM-yyyy- HH:mm:ss').format(DateTime.now()).toString()).set({
          "name":name,
          "appointmentTime1":appointmentTime1,
          "googleMeetUrl1":googleMeetUrl1,
           "appointmentTime2":appointmentTime2,
          "googleMeetUrl2":googleMeetUrl2,
           "appointmentTime3":appointmentTime3,
          "googleMeetUrl3":googleMeetUrl3,
          "docid":DateFormat('dd-MM-yyyy- HH:mm:ss').format(DateTime.now()).toString()
        

      }).onError((error, stackTrace) => res="error ocurred try again");
      res="success";
      return res;
  }
}