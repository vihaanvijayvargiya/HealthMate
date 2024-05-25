import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_mate/resources/firestore_methods.dart';
import 'package:intl/intl.dart';

import '../Widgets/input_text.dart';
class AddQuestion extends StatefulWidget {

  const AddQuestion({super.key,});

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  TextEditingController questioncontroller = TextEditingController();
  TextEditingController option1controller = TextEditingController();
  TextEditingController option2controller = TextEditingController();
  TextEditingController option3controller = TextEditingController();
  TextEditingController option4controller = TextEditingController();
  String selectedValue = 'option1';
  _submit()async{
    String res = await FirestoreMethos().addquestion(question: questioncontroller.text.trim(), option1: option1controller.text.trim(),
        option2: option2controller.text.trim(), option3: option3controller.text.trim(), option4: option4controller.text.trim(), rightans: selectedValue, );
    if(res=='success'){
      Fluttertoast.showToast(msg: 'success');
      questioncontroller.text='';
      option4controller.text='';
      option1controller.text='';
      option2controller.text='';
      option3controller.text='';

    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(DateFormat('dd/MM/yyyy - HH:mm:ss').format(DateTime.now()));
  }
  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: Width > 600
              ? EdgeInsets.symmetric(horizontal: Width / 2.9)
              : const EdgeInsets.symmetric(horizontal: 5),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                TextField(
                  controller: questioncontroller,
                  decoration: InputDecoration(
                      hintText: "Enter Question"
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: option1controller,
                  decoration: InputDecoration(
                      hintText: "Enter option 1"
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: option2controller,
                  decoration: InputDecoration(
                      hintText: "Enter option 2"
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: option3controller,
                  decoration: InputDecoration(
                      hintText: "Enter option 3"
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: option4controller,
                  decoration: InputDecoration(
                    hintText: "Enter option 4"
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FilledButton(onPressed: _submit, child: Text('  Submit  ')),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
