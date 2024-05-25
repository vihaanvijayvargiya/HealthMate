// ignore_for_file: prefer_final_fields

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:health_mate/resources/add-appointmental.dart';
import 'package:health_mate/resources/meet.dart';

class ConsultantInformation extends StatefulWidget {
  const ConsultantInformation({super.key});

  @override
  State<ConsultantInformation> createState() => _ConsultantInformationState();
}

class _ConsultantInformationState extends State<ConsultantInformation>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>>? reuqestAppointment;

  TextEditingController _controller = TextEditingController();
 
  TextEditingController _controller1time = TextEditingController();
  TextEditingController _controller1url = TextEditingController();
  
   TextEditingController _controller2time = TextEditingController();
  TextEditingController _controller2url = TextEditingController();
  // TextEditingController _controller3 = TextEditingController();
   TextEditingController _controller3time = TextEditingController();
  TextEditingController _controller3url = TextEditingController();
  // TextEditingController _controller4 = TextEditingController();
   TextEditingController _controller4time = TextEditingController();
  // TextEditingController _controller4url = TextEditingController();
  // TextEditingController _controller5 = TextEditingController();


  @override
  void initState() {
    super.initState();
    getData();
    Timer.periodic(Duration(seconds: 2), (timer) { getData();});
    _tabController = TabController(length: 2, vsync: this);
  }
  void getData()async{
    reuqestAppointment=await AddAppointRequest().featchRequestedAppointment(cons:true);
    setState(() {
      
    });
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultant Information'),
        
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Appointment Info'),
            Tab(text: 'Requested Appointments'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            scrollDirection:Axis.vertical,
            child: Column(
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _controller1time,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter First Appointment Time',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _controller1url,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter First Appointment Google Meet Url',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _controller2time,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Second Appointment Time',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _controller2url,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Second Appointment Google Meet Url',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _controller3time,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter third Appointment Time',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _controller3url,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter thrid Appointment Google Meet Url',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
               
                 ElevatedButton(onPressed:()async{
                String res=  await Meet().addAppoinmentStatus(_controller.text,_controller1time.text,_controller1url.text,_controller2time.text,_controller2url.text,_controller3time.text,_controller3url.text);
                if(res=='success'){
                  _controller.clear();
                  _controller1time.clear();
                  _controller1url.clear();
                  _controller2time.clear();
                  _controller2url.clear();
                  _controller3time.clear();
                  _controller3url.clear();
                }
                 }, 
                 child:const Text("Publish",style:TextStyle(fontWeight:FontWeight.bold),)),
                 const SizedBox(height: 16),
              ],
            ),
          ),

          //data is herehjhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
           reuqestAppointment != null && reuqestAppointment!.isNotEmpty
            ? ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var details = reuqestAppointment![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height:140,
                      width:MediaQuery.of(context).size.width*0.9,
                      color:Colors.deepPurple.withOpacity(0.1),
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.start,
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("AppointMent Time : ${details["time"]}",style:const TextStyle(fontWeight:FontWeight.bold,fontStyle:FontStyle.normal,fontSize:20),),
                          ),
                          
                          Padding(
                            padding:const EdgeInsets.all(8.0),
                            child: Expanded(child: Text("UserName: ${details["username"]}",style:const TextStyle(fontWeight:FontWeight.bold,fontStyle:FontStyle.italic,fontSize:16))),
                          ),
                          Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(onPressed:()async{
                                await AddAppointRequest().acceptRequest(details["userid"], details["docid"]);
                                getData();
                                setState(() {
                                  
                                });
                              }, child:const Text("Accept")),
                              ElevatedButton(onPressed:()async{
                                print("your data is ${details["userid"]}  ${details["docid"]}");
                                await AddAppointRequest().deleteRequest(details["userid"], details["docid"]);
                                getData();
                                setState(() {
                                  
                                });
                              }, child:const Text("Delete")),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: reuqestAppointment!.length,
              )
            : const Text("No Appointment is Available"),
        ],
      ),
    );
  }
}