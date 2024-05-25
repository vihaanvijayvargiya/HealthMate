import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class FetchQuizQuestion {
  Future<List<Map<String, String>>> fetchQuestionAndOption() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;


    try {
      QuerySnapshot querySnapshot = await _firestore.collection('khush').get();
      List<Map<String, String>> questionsAndOptions = [];

      querySnapshot.docs.forEach((doc) {
        
        DateTime today = DateTime.now();
        int day =int.parse(doc.id.substring(0,2));
        int month=int.parse(doc.id.substring(3,5));
        int year=int.parse(doc.id.substring(6,10));

        // if (year == today.year && month == today.month && day+1 == today.day) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
         // print("here di[us        snjnjsnjnsjns]    ${data.toString()}");
         print(doc.id);

          String question = data!['question'];
          String option1 = data['option1'];
          String option2 = data['option2'];
          String option3 = data['option3'];
          String option4 = data['option4'];

          Map<String, String> questionandOptions = {
            'docuid':doc.id,
            'question': question,
            'option1': option1,
            'option2': option2,
            'option3': option3,
            'option4': option4,

          };

          questionsAndOptions.add(questionandOptions);
        // }

      });
      return questionsAndOptions;
    } catch (e) {
     
      print('Error fetching quiz questions: $e');
      return [];
    }
  }
  Future<List<Map<String, String>>> getmarks(String filetername) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;


    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('admin')
          .doc(FirebaseAuth.instance.currentUser!.uid).collection('happiness').
      // doc( DateFormat('dd-MM-yyyy').format(DateTime.now()).toString())

      doc('05-05-2024') .collection('questions').get();

      List<Map<String, String>> questionsAndOptions = [];

      querySnapshot.docs.forEach((doc) {

        DateTime today = DateTime.now();
        int day =int.parse(doc.id.substring(0,2));
        int month=int.parse(doc.id.substring(3,5));
        int year=int.parse(doc.id.substring(6,10));

        // if (year == today.year && month == today.month && day+1 == today.day ) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
         // print("here di[us        snjnjsnjnsjns]    ${data.toString()}");
         print(doc.id);
          int count1 =0;
          int count2 =0;
          int count3 =0;
          int count4 =0;
          int ans = data!['ans'];
          if(ans==1){
            count1+=1;
          }
          if(ans==2){
            count2+=1;
          }
          if(ans==3){
            count3 +=1;
          }
          if(ans==4){
            count4 +=1;
          }

          Map<String, String> questionandOptions = {
            'docuid':doc.id,
            'ans1': count1.toString(),
            'ans2': count2.toString(),
            'ans3': count3.toString(),
            'ans4': count4.toString(),
          };

          questionsAndOptions.add(questionandOptions);
        // }
        // if (year == today.year && month == today.month && filetername=='month' ) {
        //   Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        //   // print("here di[us        snjnjsnjnsjns]    ${data.toString()}");
        //   print(doc.id);
        //   int count1 =0;
        //   int count2 =0;
        //   int count3 =0;
        //   int count4 =0;
        //   int ans = data!['ans'];
        //   if(ans==1){
        //     count1+=1;
        //   }
        //   if(ans==2){
        //     count2+=1;
        //   }
        //   if(ans==3){
        //     count3 +=1;
        //   }
        //   if(ans==4){
        //     count4 +=1;
        //   }
        //
        //   Map<String, String> questionandOptions = {
        //     'docuid':doc.id,
        //     'ans1': count1.toString(),
        //     'ans2': count2.toString(),
        //     'ans3': count3.toString(),
        //     'ans4': count4.toString(),
        //   };
        //
        //   questionsAndOptions.add(questionandOptions);
        // }
        // if (year == today.year && month == today.month && day == today.day && filetername=='week') {
        //   Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        //   // print("here di[us        snjnjsnjnsjns]    ${data.toString()}");
        //   print(doc.id);
        //   int count1 =0;
        //   int count2 =0;
        //   int count3 =0;
        //   int count4 =0;
        //   int ans = data!['ans'];
        //   if(ans==1){
        //     count1+=1;
        //   }
        //   if(ans==2){
        //     count2+=1;
        //   }
        //   if(ans==3){
        //     count3 +=1;
        //   }
        //   if(ans==4){
        //     count4 +=1;
        //   }
        //
        //   Map<String, String> questionandOptions = {
        //     'docuid':doc.id,
        //     'ans1': count1.toString(),
        //     'ans2': count2.toString(),
        //     'ans3': count3.toString(),
        //     'ans4': count4.toString(),
        //   };
        //
        //   questionsAndOptions.add(questionandOptions);
        // }
       // print(questionsAndOptions);
      });
      return questionsAndOptions;
    } catch (e) {

      print('Error fetching quiz questions: $e');
      return [];
    }
  }
}
