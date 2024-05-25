import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_mate/resources/auth_methos.dart';
import 'package:uuid/uuid.dart';

class AddAppointRequest {
 FirebaseFirestore _firestore = FirebaseFirestore.instance;
 FirebaseAuth _auth = FirebaseAuth.instance;

 Future<String> addAppointRequest(String googlemeetur, String appointmentTime, String docid) async {
    try {
      print("Adding appointment request...");
      var uid = const Uuid().v1();
      print("User ID: $uid");

      // Check if a request with the same userid and docid already exists
      final querySnapshot = await _firestore
          .collection("appointmentrequest")
          .where("userid", isEqualTo: _auth.currentUser!.uid)
          .where("docid", isEqualTo: docid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        print("A request with the same userid and docid already exists.");
        return "A request with the same userid and docid already exists.";
      }
       String username=await AuthMethods().getname();
      // If no existing request is found, proceed to add the new request
      await _firestore.collection("appointmentrequest").doc(uid).set({
        "userid": _auth.currentUser!.uid,
        "googlemeeturl": googlemeetur,
        "appointmentTime": appointmentTime,
        "docid": docid,
        "username":username,

        "appointmentacceptanceststus": 0
      });

      print("Appointment request added successfully.");
      return "success";
    } catch (e) {
      print("Error adding appointment request: $e");
      return e.toString();
    }
 }


 //featch all user requested of user requeed if your id is matched

   Future<List<Map<String, String>>> featchRequestedAppointment({bool cons=false}) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;


    try {
      final querySnapshot;
      if(cons){
         querySnapshot = await _firestore
          .collection("appointmentrequest").where("appointmentacceptanceststus",isEqualTo:0)
          .get();
      }else{
         querySnapshot = await _firestore
          .collection("appointmentrequest")
          .where("userid", isEqualTo: _auth.currentUser!.uid)
          .get();
      }
     
          List<Map<String, String>> questionsAndOptions = [];
  
      querySnapshot.docs.forEach((doc) {
       
        print("time is hereee wiht sipiujou");
        // if (year == today.year && month == today.month && day == today.day) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        //  print("here di[us        snjnjsnjnsjns]    ${data.toString()}");
        //  print(doc.id);

          String time = data!['appointmentTime'];
          int status = data['appointmentacceptanceststus'];
         
          String gmeeturl=data['googlemeeturl'];
          String username=data['username'];
          String docid=data['docid'];
          String userid=data['userid'];
         

          Map<String, String> appointmentDetails = {
            'time':time,
            'status':status.toString(),
            'gmeeturl': gmeeturl,
            "username":username,
            "docid":docid,
            "userid":userid
            
            

          };

          questionsAndOptions.add(appointmentDetails);
        // }

      });
      print("here is data is heer ${questionsAndOptions.toString()}");
      return questionsAndOptions; 

    
    } catch (e) {
     
      print('Error fetching quiz questions: $e');
      return [];
    }
  }

  //Accept request
  Future<void>acceptRequest(String userid,String docid)async{
    final querySnapshot = await _firestore.collection('appointmentrequest').where("userid",isEqualTo:userid).where("docid",isEqualTo:docid).get();
    // final valueare=querySnapshot.doc();
    DocumentSnapshot docToUpdate = querySnapshot.docs.first;

    // Update the document
    await docToUpdate.reference.update({
      // Specify the fields you want to update
      'appointmentacceptanceststus':1, // Replace 'fieldName' and 'newValue' with your actual field name and value
    });
  }
  Future<void>deleteRequest(String userid,String docid)async{
    final querySnapshot = await _firestore.collection('appointmentrequest').where("userid",isEqualTo:userid).where("docid",isEqualTo:docid).get();
     DocumentSnapshot docToDelete = querySnapshot.docs.first;

    // Delete the document
    await docToDelete.reference.delete();
  }
}
