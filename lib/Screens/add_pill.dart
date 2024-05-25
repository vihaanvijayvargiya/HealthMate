import 'dart:math';
import 'dart:typed_data';
// import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:workmanager/workmanager.dart';
import '../Notification Services/notifications.dart';
import '../Widgets/dropdownforquntity.dart';
import '../Widgets/dropdownforsyrup.dart';
import '../Widgets/dropdownfortimming.dart';
import '../globle.dart';
import '../provider/provider.dart';
import '../resources/firestore_methods.dart';
import '../utils.dart';

class AddPills extends StatefulWidget {
  const AddPills({super.key});

  @override
  State<AddPills> createState() => _AddPillsState();
}

class _AddPillsState extends State<AddPills> {
  bool ispill = true;
  final TextEditingController pillnamecontroller = TextEditingController();
  final TextEditingController startdatecontroller = TextEditingController();
  final TextEditingController starttimecontroller = TextEditingController();
  final TextEditingController enddatecontroller = TextEditingController();
  final TextEditingController endtimecontroller = TextEditingController();
  DateTime? startcontroller ;
  DateTime? endcontroller ;
  // TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime? startschduletime;
  DateTime? endschduletime;
  String pilltype = 'pill';
  Uint8List? _image;
  bool isimage = false;
  bool issubmit = false;


  Future<void> _selectDateTime(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );
      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        setState(() {
          controller.text = _formatDateTime(selectedDateTime);
          print(controller.text);
          if (controller == startdatecontroller) {
            startschduletime = selectedDateTime;
            print(startschduletime);
          } else if (controller == enddatecontroller) {
            endschduletime = selectedDateTime;
            print(endschduletime);
          }
        });
      }
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${DateFormat.yMMMd().format(dateTime)} ${DateFormat.jm().format(dateTime)}';
  }
  selectImage() async {
    Uint8List im = await pickImage(ImageSource.camera);
    setState(() {
      _image = im;
      isimage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'Add Pill',
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white),
        ),
        backgroundColor: deepColor,
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          width: width > 600
              ? MediaQuery.of(context).size.width / 1.9
              : double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Stack(
                //   children: [
                //     _image != null
                //         ? CircleAvatar(
                //       radius: 64,
                //       backgroundImage: MemoryImage(_image!),
                //       backgroundColor: Colors.white12,
                //     )
                //         : const CircleAvatar(
                //       radius: 64,
                //       backgroundImage:AssetImage('assets/capsul.png',),
                //       backgroundColor: Colors.white12,
                //     ),
                //     Positioned(
                //       bottom: -12,
                //       left: 90,
                //       child: IconButton(
                //         onPressed: selectImage,
                //         icon: const Icon(Icons.add_a_photo),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                TextField(
                  controller: pillnamecontroller,
                  decoration: InputDecoration(
                    label: Text("Enter pill name"),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7.0, vertical: 7),
                  child: Text(
                    'Medicine form',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: Container()),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (ispill == true) {
                                ispill = false;
                                pilltype = 'syrup';
                                setState(() {});
                              } else {
                                ispill = true;
                                pilltype = 'pill';
                                setState(() {});
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ispill
                                      ? deepColor
                                      : Colors.grey[200]),
                              child: Image.asset('assets/pill.png'),
                            ),
                          ),
                        ),
                        Text(
                          'Pill',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (ispill == true) {
                            ispill = false;
                            pilltype = 'syrup';
                            setState(() {});
                          } else {
                            ispill = true;
                            pilltype = 'pill';
                            setState(() {});
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: !ispill
                                      ? deepColor
                                      : Colors.grey[200]),
                              child: Image.asset('assets/syrup.png'),
                            ),
                            Text(
                              'Syrup',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7.0, vertical: 7),
                      child: Text(
                        'Add ammount',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                        child: ispill ? DropDownForPill() : DropDownForSyrup()),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7.0, vertical: 7),
                      child: Text(
                        'Select Start date & time',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                    TextField(
                      controller: startdatecontroller,
                      readOnly: true,
                      onTap: () {
                        _selectDateTime(context, startdatecontroller);

                      },
                      decoration: InputDecoration(
                        label: Text("Select Start date & time"),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7.0, vertical: 7),
                      child: Text(
                        'Select timming',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(child: DropDownForTimming()),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7.0, vertical: 7),
                      child: Text(
                        'Select end date & time',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                    TextField(
                      controller: enddatecontroller,
                      readOnly: true,
                      onTap: () => _selectDateTime(context, enddatecontroller),
                      decoration: InputDecoration(
                        label: Text("Select end date & time"),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: ()async{
                    setState(() {
                      issubmit = true;
                    });
                    String ans ='';
                    var uid =Random().nextInt(10000000);
                       ans = await FirestoreMethos().addpill(
                        pillname: pillnamecontroller.text.trim(),
                        pilltype: pilltype,
                        pillamount: ispill ? selectedpill : selectedsyrup,
                        startdate:startdatecontroller.text ,
                        enddate: enddatecontroller.text,
                        timming: selectedTimming,
                        isimage:isimage,
                        notificationuid: uid,
                      );

                    if(ans == 'success') {
                      LocalNotifications.showScheduleNotification(
                        id: uid,
                        title: "Time to take your medicine",
                        body: "pillname : ${pillnamecontroller.text}\nquantity : ${ispill ? selectedpill : selectedsyrup}",
                        payload: "This is schedule data",
                        startdateTime: startschduletime!,
                        enddateTime: endschduletime!,
                      );
                      // var minites = minutesUntil(startschduletime!);
                      // print(minites);
                      // Workmanager().registerOneOffTask(
                      //     "notification", "simpleTask",
                      //   inputData: <String, dynamic>{
                      //     'id': uid,
                      //     'title': "Time to take your medicine",
                      //     'body': "pillname : ${pillnamecontroller.text}\nquantity : ${ispill ? selectedpill : selectedsyrup}",
                      //     'payload': "This is schedule data",
                      //     'startDateTime': startschduletime!.millisecondsSinceEpoch,
                      //     'endDateTime': endschduletime!.millisecondsSinceEpoch,
                      //   },
                      //   initialDelay: Duration(minutes: minites)
                      // );
                      // await AndroidAlarmManager.periodic(
                      //   const Duration(minutes: 1), // Repeat every day
                      //   uid, // Unique ID for the alarm
                      //   await LocalNotifications.schedulePeriodicNotifications(
                      //     id: uid,
                      //     title: "Time to take your medicine",
                      //     body: "pillname : ${pillnamecontroller.text}\nquantity : ${ispill ? selectedpill : selectedsyrup}",
                      //     payload: "This is schedule data",
                      //     startdateTime: startschduletime!,
                      //     enddateTime: endschduletime!,
                      //   ), // Function to be called
                      //   startAt: startschduletime!, // Start the alarm at 9 PM
                      //   exact: true, // Execute exactly at the specified time
                      //   wakeup: true, // Wake up the device to execute the task
                      //   rescheduleOnReboot: true, // Reschedule the alarm after device reboot
                      // );
                      setState(() {
                        issubmit = true;
                      });
                      Fluttertoast.showToast(msg: 'Added:');
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: deepColor,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(child: issubmit ? CircularProgressIndicator(color: Colors.white,):Text('Add Medicine',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),)),

                  ),
                ),

                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  int minutesUntil(DateTime targetDate) {
    final now = DateTime.now();
    final difference = targetDate.difference(now);
    return difference.inMinutes;
  }

}
