import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../globle.dart';



class DropDownForFilter extends StatefulWidget {
  @override
  _DropDownForFilterState createState() => _DropDownForFilterState();
}

class _DropDownForFilterState extends State<DropDownForFilter> {


  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
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
            value: value8,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Colors.white),
                  color: selectedfilter == value8 ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10)
              ),

              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  value8,
                  style: TextStyle(
                    fontSize: 16.0,

                  ),
                ),
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: value9,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Colors.white),
                  color: selectedfilter == value9 ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10)
              ),
              width: 300,
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  value9,
                  style: TextStyle(
                    fontSize: 16.0,

                  ),
                ),
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: value10,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Colors.white),
                  color: selectedfilter == value10 ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10)
              ),
              width: 300,
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  value10,
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
    );
  }
}

