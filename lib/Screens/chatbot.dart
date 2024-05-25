import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:health_mate/Screens/webview.dart';
import 'package:health_mate/globle.dart';

import 'MessagesScreen.dart';
import 'package:keyboard_hider/keyboard_hider.dart';
class Chatbot extends StatefulWidget {
  final id;
  const Chatbot({super.key,  this.id='hello'});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller =TextEditingController();
  List<Map<String,dynamic>> messages =[];
  final _focusNode=FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hideTextInput();
    DialogFlowtter.fromFile().then((value) => dialogFlowtter=value);
    // FocusScopeNode currentFocus = FocusScope.of(context);
  }
  @override
  Widget build(BuildContext context) {
    return KeyboardHider(
      mode: HideMode.hideTextInput,
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title: Text(widget.id!),
        // ),
        body: Container(
          child: Column(
            children: [
              Expanded(child: MessagesScreen(messages: messages)),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                margin: EdgeInsets.symmetric(vertical: 5),
                // color: Colors.deepPurple,
                child: Row(
                  children: [
                    Expanded(

                        child: TextField(

                          controller: _controller,
                          // cursorColor: Colors.white,
                          // style: TextStyle(color: Colors.white),
                          autofocus:false,
                          focusNode:_focusNode,
                          // onEditingComplete:(){
                          //   FocusScopeNode currentFocus = FocusScope.of(context);
                          // },
                          decoration: InputDecoration(
                            label: Text('Enter text'),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black,width: 1.5),
                                borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                        )),
                    SizedBox(width: 10,),
                    InkWell(
                      onLongPress: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>BotWeb()));
                      },
                       onTap: (){
                        sendMessage(_controller.text);
                       _controller.clear();},

                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22.5),
                          color: deepColor
                        ),
                        child: Center(child: Icon(Icons.send,color: Colors.white,))
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)),
        // queryParams: QueryParameters(knowledgeBases: ['your_knowledge_base_name']),

      );
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
