import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../globle.dart';



class DropDownForSyrup extends StatefulWidget {
  @override
  _DropDownForSyrupState createState() => _DropDownForSyrupState();
}

class _DropDownForSyrupState extends State<DropDownForSyrup> {


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
            selectedsyrup = value;
          });
        },
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[

            PopupMenuItem<String>(
              value: value4,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.white),
                    color: selectedsyrup == value4 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(10)
                ),

                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    value4,
                    style: TextStyle(
                      fontSize: 16.0,

                    ),
                  ),
                ),
              ),
            ),
            PopupMenuItem<String>(
              value: value5,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.white),
                    color: selectedsyrup == value5 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(10)
                ),
                width: 300,
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    value5,
                    style: TextStyle(
                      fontSize: 16.0,

                    ),
                  ),
                ),
              ),
            ),
            PopupMenuItem<String>(
              value: value6,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.white),
                    color: selectedsyrup == value6 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(10)
                ),
                width: 300,
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    value6,
                    style: TextStyle(
                      fontSize: 16.0,

                    ),
                  ),
                ),
              ),
            ),
            PopupMenuItem<String>(
              value: value7,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.white),
                    color: selectedsyrup == value7 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(10)
                ),
                width: 300,
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    value7,
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
                selectedsyrup ?? 'Select an item',
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
