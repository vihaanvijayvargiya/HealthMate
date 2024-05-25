import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_mate/Screens/happiness_juice_screen.dart';
import 'package:health_mate/Screens/helth_main_screen.dart';
import 'package:health_mate/resources/firestore_methods.dart';

import '../Widgets/question_widget.dart';
class QuestionS extends StatefulWidget {
  final List<Map<String, String>> queslist;
  const QuestionS({super.key, required this.queslist});

  @override
  State<QuestionS> createState() => _QuestionSState();
}

class _QuestionSState extends State<QuestionS> {
  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Questions',style: TextStyle(color: Colors.white),),
      ),
      body: Container(

        child:ListView.builder(
                itemCount: widget.queslist.length+1,
                itemBuilder: (context, index) {
                  return index == widget.queslist.length
                      ? Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: Width > 600 ? Width/3 : 30,
                        vertical: Width > 600 ? 15 : 10,
                      ),
                      width: double.infinity,
                      child: FilledButton(onPressed:(){
                        _submit();
                        }, child: Text('Submit'))
                  )
                      : QuestionWidget(
                    snap: widget.queslist[index],
                    index: index + 1,
                  );
                })
    )


    );
  }

  void _submit() async{
   var res = await FirestoreMethos().submitQuestion();
   Fluttertoast.showToast(msg: res);
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HealthMainScreen()));
  }
}
