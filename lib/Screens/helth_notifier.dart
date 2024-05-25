import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_mate/globle.dart';
import 'package:health_mate/resources/firestore_methods.dart';
import '../Notification Services/notifications.dart';
import 'add_pill.dart';
import 'package:app_settings/app_settings.dart';
import 'package:keyboard_hider/keyboard_hider.dart';
class HealthNotifierScreen extends StatefulWidget {
  const HealthNotifierScreen({super.key});

  @override
  State<HealthNotifierScreen> createState() => _HealthNotifierScreenState();
}

class _HealthNotifierScreenState extends State<HealthNotifierScreen> {
  int? id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hideTextInput();
    // FocusScopeNode currentFocus = FocusScope.of(context);
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return KeyboardHider(
      mode : HideMode.hideTextInput,
      child: Scaffold(
        body: Center(
          // child: Text("HOMEScreen"),
          child: Container(
            color: Colors.white,
            width: width > 600
                ? MediaQuery.of(context).size.width / 1.9
                : double.infinity,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('admin')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('pills')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  padding: MediaQuery.of(context).size.width > 600
                      ? EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/ 2)
                      : const EdgeInsets.symmetric(horizontal: 5),
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (ctx, index) => Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: width > 600 ? width * 0.3 : 0,
                          vertical: width > 600 ? 15 : 0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 1)),
                            child: Stack(children: [
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Container(
                                      height: 100,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: lightColor),
                                      child: snapshot.data!.docs[index]
                                                  .data()['pillimage'] !=
                                              null
                                          ? Image.network(snapshot.data!.docs[index]
                                              .data()['pillimage'])
                                          :  snapshot.data!.docs[index].data()['pillimage']!=null?
                                      Image.network(snapshot.data!.docs[index].data()['pillimage'],width: 80,): Image.asset(
                                              'assets/${snapshot.data!.docs[index].data()['pilltype']}.png'),

                                    ),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 5, right: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Name',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  'Quantity',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  'From',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  'To',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  ': ${snapshot.data!.docs[index].data()['pillname']}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'itelic',
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  ': ${snapshot.data!.docs[index].data()['pillamount']}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'itelic',
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  ': ${snapshot.data!.docs[index].data()['startdate']}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'itelic',
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  ': ${snapshot.data!.docs[index].data()['enddate']}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'itelic',
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                              Positioned(
                                  right: 0,
                                  top: 0,
                                  child: IconButton(
                                    icon: Icon(Icons.more_vert),
                                    onPressed: () {
                                      _showdialog(
                                          context,
                                          snapshot.data!.docs[index]
                                              .data()['noteuid'],
                                          snapshot.data!.docs[index].data()['uid']);
                                    },
                                  ))
                            ]),
                          ),
                        )),
                  ),
                );
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: deepColor,
          onPressed: () {
            // AppSettings.openAppSettings(type: AppSettingsType.device);
      
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddPills()));
          },
        ),
      ),
    );
  }

  _showdialog(BuildContext context, int id, String docid) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            // backgroundColor: Colors.black,
            children: [
              SimpleDialogOption(
                  padding: EdgeInsets.all(20),
                  child: Center(
                      child: Text(
                    'Delete',
                    style: TextStyle(fontSize: 20),
                  )),
                  onPressed: () {
                    LocalNotifications.cancel(id);
                    _delete(docid);
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  void _delete(String uid) async {
    String res = await FirestoreMethos().delete(uid);
    Fluttertoast.showToast(msg: res);
  }
}
