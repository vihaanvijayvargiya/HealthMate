

import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:health_mate/Screens/helth_notifier.dart';
import 'package:tflite/tflite.dart';



class MyModelImage extends StatefulWidget {
  const MyModelImage({Key? key});

  @override
  State<MyModelImage> createState() => _MyModelImageState();
}

class _MyModelImageState extends State<MyModelImage> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';
  late List<CameraDescription> cameras;
  int selectedCameraIndex = 0;
  List healthResult=[0,0,0,0];
  int timer=30;

  @override
  void initState() {
    super.initState();
    output='';
    loadCameras();
    loadModel();
  }

  loadCameras() async {
    cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      setState(() {
        cameraController =
            CameraController(cameras[selectedCameraIndex+1], ResolutionPreset.medium);
        cameraController!.initialize().then((value) {
         if(!mounted){
        return;
      }else{
        setState(() {
          cameraController!.startImageStream((imageStream) { 
            cameraImage=imageStream;
            runModel();
          });
        });
      }
        });
      });
    }
  }

  toggleCamera() {
    timer=30;
    timerfinised=false;
    output='';
    setState(() {
      selectedCameraIndex = (selectedCameraIndex+1) % cameras.length;
      cameraController = CameraController(cameras[selectedCameraIndex], ResolutionPreset.medium);
      cameraController!.initialize().then((_) {
       if(!mounted){
        return;
      }else{
        setState(() {
          cameraController!.startImageStream((imageStream) { 
            cameraImage=imageStream;
            
            runModel();
            output='';
          });
        });
      }
      });
    });
  }
 loadModel()async{
    await Tflite.loadModel(model:'assets/cotentname/model_unquant.tflite',
    labels:'assets/cotentname/labels.txt');
    
  }
  runModel()async{
    if(cameraImage!=null){
      var prediction=await Tflite.runModelOnFrame(bytesList:cameraImage!.planes.map((plane){
        return plane.bytes;
      }).toList(),
      imageHeight:cameraImage!.height,
      imageWidth:cameraImage!.width,
      imageMean:127.5,
      imageStd:127.5,
      rotation:90,
      numResults:2,
      threshold:0.1,
      asynch:true
      );
      prediction!.forEach((element) {
        // setState(() {
          output=element['label'];
          if(output=='0 Good-Mental-Heath'){
            healthResult[0]++;
          }else if(output=='1 Bad-Mental-Health'){
            healthResult[1]++;
          }else if(output=='2 Normal-Mental-Health'){
            healthResult[2]++;
          }else{
            healthResult[3]++;
          }
          
        });
      // });
    }
  }
  bool timerfinised=false;
  // Other methods remain unchanged...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(child: const Text("Facial Analysis",style:TextStyle(fontWeight:FontWeight.bold),),onTap:(){Navigator.pop(context);},),
        // Color deepColor = Colors.deepPurple/.shade300;
      backgroundColor:Colors.deepPurple.shade300,
        toolbarHeight:70,
      ),
      body: SingleChildScrollView(
        scrollDirection:Axis.vertical,
        child: Column(
          
          children: [
            const Center(child:Text("Check Result will become active",style:TextStyle(fontWeight:FontWeight.bold,fontSize:18),)),
            const Center(child:Text("after one minitue",style:TextStyle(fontWeight:FontWeight.bold,fontSize:18),)),
            TimerCountdown(
          format: CountDownTimerFormat.daysHoursMinutesSeconds,
          endTime: DateTime.now().add(
            Duration(
              days: 0,
              hours: 0,
              minutes: 0,
              seconds: timer,
            ),
          ),
          onEnd: () {
            print("Timer finished");
            timerfinised=true;
            setState(() {
              
            });
          },
        ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: cameraController != null && cameraController!.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: cameraController!.value.aspectRatio,
                        child: CameraPreview(cameraController!),
                      )
                    : Container(),
              ),
            ),
            // Text(
            //   output,
            //   style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            // ),
            ElevatedButton(
              onPressed: toggleCamera,
              child:const Icon(Icons.flip_camera_ios),
            ),
            ElevatedButton(
              onPressed:!timerfinised?null:(){
                int maxval=healthResult[0],index=0;
               for(int i=1;i<healthResult.length;i++){
                if(healthResult[i]>maxval){
                  maxval=healthResult[i];
                  index=i;
                }
                if(i==0){
                  output="Good Mental Health";
                }else if(i==1){
                  output="Bad metal health";
                }else if(i==2){
                  output="Normal mental health";
                }else{
                  output="Random";
                }
                
                Navigator.pop(context);
                    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Result"),
          content: Text(output),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
                              }
              },
              child:const Text("Check Result"),
            ),
          ],
        ),
      ),
    );
  }
}
