import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HTTPResponse extends StatefulWidget {
  final data;
  const HTTPResponse({super.key, required this.data});

  @override
  State<HTTPResponse> createState() => _HTTPResponseState();
}

class _HTTPResponseState extends State<HTTPResponse> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Response'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text('Response Code:'
            '${widget.data.toString()}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
      ),
    );

  }
}
