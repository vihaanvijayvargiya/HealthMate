import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health_mate/Screens/webviewformeet.dart';
import 'package:health_mate/resources/add-appointmental.dart';
import 'package:health_mate/resources/featch-appointment-details.dart';
import 'package:url_launcher/url_launcher.dart';

class BookSlot extends StatefulWidget {
 const BookSlot({Key? key}) : super(key: key);

 @override
 State<BookSlot> createState() => _BookSlotState();
}

class _BookSlotState extends State<BookSlot>with SingleTickerProviderStateMixin  {
 Map<String, bool> _selectedSlots = {};

 List<Map<String, dynamic>>? appointmentDetails;
 List<Map<String, dynamic>>? reuqestAppointment;
 
 int ? selectedIndex;
 bool tapStatus=false;
 late TabController _tabController;
 @override
 void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getData();
    Timer.periodic(Duration(seconds: 2), (timer) { getData();});

 }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

 void getData() async {
    appointmentDetails = await FeatchAppointmentDetails().featchAppointmentDetails();
  reuqestAppointment =await AddAppointRequest().featchRequestedAppointment();
    _selectedSlots = {};
    for (var detail in appointmentDetails!) {
      _selectedSlots[detail["name"]! + "appointmentTime1"] = false;
      _selectedSlots[detail["name"]! + "appointmentTime2"] = false;
      _selectedSlots[detail["name"]! + "appointmentTime3"] = false;
    }
    setState(() {});
    print("Hello, I am Divyansh ${appointmentDetails}");
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center( child:Text('Book Your Appointment',style:TextStyle(fontWeight:FontWeight.w700),)),
        centerTitle:true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Appointments'),
            Tab(text: 'Request Status'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children:[appointmentDetails != null && appointmentDetails!.isNotEmpty
            ? ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return schedule(context, index);
                },
                itemCount: appointmentDetails!.length,
              )
            : const Text("No Appointment is Available"),
          reuqestAppointment != null && reuqestAppointment!.isNotEmpty
            ? ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var details = reuqestAppointment![index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height:120,
                      width:MediaQuery.of(context).size.width*0.9,
                      color:Colors.deepPurple.withOpacity(0.1),
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.start,
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text("AppointMent Time : ${details["time"]}",style:const TextStyle(fontWeight:FontWeight.bold,fontStyle:FontStyle.normal,fontSize:20),),
                          ),
                          
                          int.parse(details["status"])==1?Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: ()async{
                                if (await canLaunch('https://meet.google.com/gun-vith-kdk?authuser=0')) {
                                await launch('https://meet.google.com/gun-vith-kdk?authuser=0');
                                } else {
                                throw 'Could not launch https://meet.google.com/gun-vith-kdk?authuser=0';
                                }
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>MeetWeb(url: details['gmeeturl'],)));
                              },
                                child: Text("Join Url: ${details["gmeeturl"]}",style:const TextStyle(color:Colors.deepPurple,fontWeight:FontWeight.bold,fontStyle:FontStyle.italic,fontSize:20))),
                          ):const Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: Expanded(child: Text("Google Meet url is not present because your request is not accepted",style: TextStyle(fontWeight:FontWeight.bold,fontStyle:FontStyle.italic,fontSize:16))),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: reuqestAppointment!.length,
              )
            : const Text("No Appointment is Available"),
        ]
      ),
      
    );
 }

 Padding schedule(BuildContext context, int index) {
    var detail = appointmentDetails![index];
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Container(
        height: 130,
        width: MediaQuery.of(context).size.width * 0.9,
        color: Colors.deepPurple.withOpacity(0.1),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 8),
                child: Text(
                 "Consultant Name: ${detail["name"]}",
                 style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex=1;
                        _selectedSlots[detail["name"]! + "appointmentTime1"] = true;
                        _selectedSlots[detail["name"]! + "appointmentTime2"] = false;
                        _selectedSlots[detail["name"]! + "appointmentTime3"] = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.25,
                        color: _selectedSlots[detail["name"]! + "appointmentTime1"] == true
                            ? Colors.deepPurple
                            : Colors.deepPurple.withOpacity(0.5),
                        child: Center(
                          child: Text(
                            detail["appointmentTime1"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _selectedSlots[detail["name"]! + "appointmentTime1"] == true ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                 ),
                 GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex=2;
                        _selectedSlots[detail["name"]! + "appointmentTime2"] = true;
                        _selectedSlots[detail["name"]! + "appointmentTime1"] = false;
                        _selectedSlots[detail["name"]! + "appointmentTime3"] = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.25,
                        color: _selectedSlots[detail["name"]! + "appointmentTime2"] == true
                            ? Colors.deepPurple
                            : Colors.deepPurple.withOpacity(0.5),
                        child: Center(
                          child: Text(
                            detail["appointmentTime2"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _selectedSlots[detail["name"]! + "appointmentTime2"] == true ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                 ),
                 GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex=3;
                        _selectedSlots[detail["name"]! + "appointmentTime3"] = true;
                        _selectedSlots[detail["name"]! + "appointmentTime1"] = false;
                        _selectedSlots[detail["name"]! + "appointmentTime2"] = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.25,
                        color: _selectedSlots[detail["name"]! + "appointmentTime3"] == true
                            ? Colors.deepPurple
                            : Colors.deepPurple.withOpacity(0.5),
                        child: Center(
                          child: Text(
                            detail["appointmentTime3"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _selectedSlots[detail["name"]! + "appointmentTime3"] == true ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                 ),
                ],
              ),
              Center(child: ElevatedButton(onPressed:selectedIndex!=null?
              ()async{
                tapStatus=true;
                setState(() {
                  
                });
                String res='';
                if(selectedIndex==1){
                 res= await AddAppointRequest().addAppointRequest(detail["googleMeetUrl1"], detail["appointmentTime1"],detail["docid"]);
                  print("details of apppoint ment ${detail["appointmentTime1"]} ");
                }else if(selectedIndex==2){
                    res=await AddAppointRequest().addAppointRequest(detail["googleMeetUrl2"], detail["appointmentTime1"],detail["docid"]);
                  print("details of apppoint ment ${detail["appointmentTime2"]} ");
                }else if(selectedIndex==3){
                  res=await AddAppointRequest().addAppointRequest(detail["googleMeetUrl3"], detail["appointmentTime3"],detail["docid"]);
                  print("details of apppoint ment ${detail["googleMeetUrl3"]}   ${detail["docid"]} ");
                }
                if(res=="success"){
                  print("your requested is submitted");

                }
                tapStatus=false;
                setState(() {
                  
                });
              }:null, 
              child:tapStatus==false?const Text("Send Request"):const CircularProgressIndicator()))
            ],
          ),
        ),
      ),
    );
 }
}
