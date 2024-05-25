import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_mate/Widgets/cust_icon.dart';
import 'package:health_mate/globle.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:keyboard_hider/keyboard_hider.dart';
class Emergency extends StatefulWidget {
  const Emergency({super.key});

  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  String tel = '9575761998';
  @override
  void initState(){
    super.initState();
    hideTextInput();
    // FocusScopeNode currentFocus = FocusS/cope.of(context);
  }
  void _launchPhoneCall(String phoneNumber) async {
    final url = Uri(scheme: 'tel', path: phoneNumber.toString());
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // Handle the case where the phone app cannot be launched
      print('Could not launch $url');
      Fluttertoast.showToast(msg: 'Could not launch phone dialer');
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardHider(
      mode: HideMode.hideTextInput,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: lightColor),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          'AMBULANCE',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          onPressed: () {
                            _launchPhoneCall('102');
                          },
                          icon: Icon(Icons.call),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: lightColor),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'NATIONAL EMERGENCY NUMBER',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          onPressed: () {
                            _launchPhoneCall('112');
                          },
                          icon: Icon(Icons.call),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: lightColor),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          'POLICE ',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          onPressed: () {
                            _launchPhoneCall('100');
                          },
                          icon: Icon(Icons.call),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: lightColor),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          'FIRE',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          onPressed: () {
                            _launchPhoneCall('101');
                          },
                          icon: Icon(Icons.call),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: lightColor),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          'Women Helpline ',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          onPressed: () {
                            _launchPhoneCall('1091');
                          },
                          icon: Icon(Icons.call),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: lightColor),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Women Helpline-(Domestic Abuse)  ',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          onPressed: () {
                            _launchPhoneCall('181');
                          },
                          icon: Icon(Icons.call),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:lightColor),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          'Children In Difficult Situation  ',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          onPressed: () {
                            _launchPhoneCall('1098');
                          },
                          icon: Icon(Icons.call),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: lightColor),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          'LPG Leak Helpline  ',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          onPressed: () {
                            _launchPhoneCall('1906');
                          },
                          icon: Icon(Icons.call),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: lightColor),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          'COVID 19 HELPLINE ',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          onPressed: () {
                            _launchPhoneCall('1075');
                          },
                          icon: Icon(Icons.call),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('Find Nearby Locations',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustIcon(name: 'Hospitols', iconname: 'assets/hosp.jpg', onTap: (){
                      String query = 'Near Hospitols'; // Replace with your desired query
                      MapsLauncher.launchQuery(query);
                    }),
                     SizedBox(width: 10,),
                     CustIcon(name: 'Schools', iconname: 'assets/sch.jpg', onTap: (){
                      String query = 'Near Schools'; // Replace with your desired query
                      MapsLauncher.launchQuery(query);
                    }),
                    SizedBox(width: 10,),
                     CustIcon(name: 'Fire Stations', iconname: 'assets/fire.jpg', onTap: (){
                      String query = 'Near FireStations'; // Replace with your desired query
                      MapsLauncher.launchQuery(query);
                    }),

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
