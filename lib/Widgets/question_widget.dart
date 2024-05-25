import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_mate/resources/firestore_methods.dart';


class QuestionWidget extends StatefulWidget {
  final snap;
  final index;
  const QuestionWidget(
      {super.key, required this.snap, this.index,});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int selectedValue = 0;
  Future<void> check() async {
    print(widget.snap['ans']);
    print('option$selectedValue');
       String res= await FirestoreMethos().updateans(uid: widget.snap['docuid'], ans: selectedValue);
       print(res);
       // Fluttertoast.showToast(msg: 'selected');


  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: width > 600 ? width * 0.3 : 30,
          vertical: width > 600 ? 15 : 10,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromRGBO(193, 174, 242, 100),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ListTile(
            leading: Text(
              '${widget.index.toString()})',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            title: Text(
              '${widget.snap['question'].toString()}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          RadioListTile(
            value: 1,
            groupValue: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as int;
                print(selectedValue);
                check();
              });
            },
            title: Text(
              widget.snap['option1'].toString(),
              style: TextStyle(fontSize: 17),
            ),
          ),
          RadioListTile(
            value: 2,
            groupValue: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as int;
                check();
                print('\n');
                print(selectedValue);
              });
            },
            title: Text(
              widget.snap['option2'].toString(),
              style: TextStyle(fontSize: 17),
            ),
          ),
          RadioListTile(
            value: 3,
            groupValue: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as int;
                check();
                print('\n');
                print(selectedValue);
              });
            },
            title: Text(
              widget.snap['option3'].toString(),
              style: TextStyle(fontSize: 17),
            ),
          ),
          RadioListTile(
            value: 4,
            groupValue: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as int;
                check();
                print('\n');
                print(selectedValue);
              });
            },
            title: Text(
              widget.snap['option4'].toString(),
              style: TextStyle(fontSize: 17),
            ),
          ),
        ]));
  }
}
