import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();

// on tap on any notification
  static void onNotificationTap(NotificationResponse notificationResponse) {
    onClickNotification.add(notificationResponse.payload!);
  }

// initialize the local notifications
  static Future init() async {


    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    // final DarwinInitializationSettings initializationSettingsDarwin =
    // DarwinInitializationSettings(
    //   onDidReceiveLocalNotification: (id, title, body, payload) => null,
    // );
    // final LinuxInitializationSettings initializationSettingsLinux =
    // LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        // iOS: initializationSettingsDarwin,
        // linux: initializationSettingsLinux gb
        );
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  // // show a simple notification
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }
  static Future showScheduleNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    required DateTime startdateTime,
    required DateTime enddateTime,
  }) async {
    // for (DateTime date = startdateTime; date.isBefore(
    //    enddateTime); date = date.add(Duration(minutes: 1))) {
      // Create the notification date-time
      final tz.TZDateTime scheduledDate = tz.TZDateTime.from(
          startdateTime,
          tz.local
      );
      await _flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          scheduledDate,
          const NotificationDetails(
              android: AndroidNotificationDetails(
                  'channel 3', 'your channel name',
                  channelDescription: 'your channel description',
                  importance: Importance.max,
                  priority: Priority.high,
                  ticker: 'ticker')),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
          payload: payload,
        matchDateTimeComponents: DateTimeComponents.time,
      );

  }

  // @pragma('vm:entry-point')
  static Future schedulePeriodicNotifications({
    required int id,
    required String title,
    required String body,
    required String payload,
    required DateTime startdateTime,
    required DateTime enddateTime,
  }) async {
    final AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'channel 2',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    final NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    // Schedule a one-time notification in the future
    await _flutterLocalNotificationsPlugin.periodicallyShow(
        id,
        title,
        body,
        RepeatInterval.everyMinute,
        notificationDetails,
        androidAllowWhileIdle: true,
        payload: payload,
    );

    // Schedule periodic notifications from the initialDateTime onward
  }

  static Future<String> cancel(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
    return 'done';
  }
}