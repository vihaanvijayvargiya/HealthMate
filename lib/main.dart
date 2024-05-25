// import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:camera/camera.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:health_mate/Screens/spleshScreen.dart';
import 'package:health_mate/admin/add.dart';
import 'package:health_mate/globle.dart';
import 'package:health_mate/provider/provider.dart';
import 'package:health_mate/resources/featchQuizQuestion.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'Notification Services/notifications.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timezone/data/latest.dart' as tz;

// @pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) {
//     final id = inputData!['id'] as int;
//     final title = inputData['title'] as String;
//     final body = inputData['body'] as String;
//     final payload = inputData['payload'] as String;
//     final startDateTime = DateTime.fromMillisecondsSinceEpoch(inputData['startDateTime'] as int);
//     final endDateTime = DateTime.fromMillisecondsSinceEpoch(inputData['endDateTime'] as int);
//     if (task == "pill_reminder_task") {
//       LocalNotifications.schedulePeriodicNotifications(
//           id: id,
//           title: title,
//           body: body,
//           payload: payload,
//           startdateTime: startDateTime,
//           enddateTime: endDateTime);
//     }//simpleTask will be emitted here.
//     return Future.value(true);
//   });
//
//   }
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
//   await Firebase.initializeApp();
// }
List<CameraDescription>? cameras;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras=await availableCameras();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  tz.initializeTimeZones();
  await LocalNotifications.init();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // colorScheme: ColorScheme.dark(),
         primarySwatch: Colors.deepPurple,
          buttonTheme: ButtonThemeData(
            buttonColor: deepColor,
          ),
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple,width: 1.5),
                borderRadius: BorderRadius.circular(8)
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black,width: 1.5),
                borderRadius: BorderRadius.circular(8)
            ),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black,width: 1.5),
                borderRadius: BorderRadius.circular(8)
            ),

          ),
        ),

        home:const SpleshScreen(),

      ),
    );
  }
}



