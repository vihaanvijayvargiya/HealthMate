import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_mate/globle.dart';

class DropDownForPill extends StatefulWidget {
  @override
  _DropDownForPillState createState() => _DropDownForPillState();
}

class _DropDownForPillState extends State<DropDownForPill> {


  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black,width: 1.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: PopupMenuButton<String>(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        offset: Offset(10,10),
        elevation: 8,
        // color: colors,
        onSelected: (String value) {
          setState(() {
            selectedpill = value;
          });
        },
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[

            PopupMenuItem<String>(
              value: value1,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.white),
                    color: selectedpill == value1 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(10)
                ),

                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    value1,
                    style: TextStyle(
                      fontSize: 16.0,

                    ),
                  ),
                ),
              ),
            ),
            PopupMenuItem<String>(
              value: value2,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.white),
                    color: selectedpill == value2 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(10)
                ),
                width: 300,
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    value2,
                    style: TextStyle(
                      fontSize: 16.0,

                    ),
                  ),
                ),
              ),
            ),
            PopupMenuItem<String>(
              value: value3,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.white),
                    color: selectedpill == value3 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(10)
                ),
                width: 300,
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    value3,
                    style: TextStyle(
                      fontSize: 16.0,

                    ),
                  ),
                ),
              ),
            ),

          ];
        },
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
               selectedpill ?? 'Select an item',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
