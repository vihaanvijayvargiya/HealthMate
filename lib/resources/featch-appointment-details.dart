import 'package:cloud_firestore/cloud_firestore.dart';

class FeatchAppointmentDetails {
  Future<List<Map<String, String>>> featchAppointmentDetails() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;


    try {
      QuerySnapshot querySnapshot = await _firestore.collection('Appointment').get();
      List<Map<String, String>> questionsAndOptions = [];
    print("ui anajjsjjhhhhhhhhhhhhhabhbhaba abhghgah aaaaaaa");
      querySnapshot.docs.forEach((doc) {
        print("ui anajjsjjhhhhhhhhhhhhhabhbhaba abhghgah aaaaaaa ${doc.toString()}  ${doc.id}");
        DateTime today = DateTime.now();
        int day =int.parse(doc.id.substring(0,2));
        int month=int.parse(doc.id.substring(3,5));
        int year=int.parse(doc.id.substring(6,10));

        // if (year == today.year && month == today.month && day == today.day) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
         print("here di[us        snjnjsnjnsjns]    ${data.toString()}");
        //  print(doc.id);

          String name = data!['name'];
          String appointmentTime1 = data['appointmentTime1'];
          String googleMeetUrl1 = data['googleMeetUrl1'];
          String appointmentTime2 = data['appointmentTime2'];
          String googleMeetUrl2 = data['googleMeetUrl2'];
          String appointmentTime3 = data['appointmentTime3'];
          String googleMeetUrl3 = data['googleMeetUrl3'];
          String docid=data['docid'];
         

          Map<String, String> appointmentDetails = {
            'name':name,
            'appointmentTime1':appointmentTime1,
            'googleMeetUrl1': googleMeetUrl1,
            'appointmentTime2':appointmentTime2,
            'googleMeetUrl2':googleMeetUrl2,
            'appointmentTime3':appointmentTime3,
            'googleMeetUrl3': googleMeetUrl3,
            'docid':docid
            

          };

          questionsAndOptions.add(appointmentDetails);
        // }

      });
      return questionsAndOptions;
    } catch (e) {
     
      print('Error fetching quiz questions: $e');
      return [];
    }
  }
}